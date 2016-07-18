class Bill < ActiveRecord::Base
  has_many :movements, :dependent => :destroy

  attr_accessor :periodo_mask

  before_save :check_limites

  belongs_to :school
  belongs_to :user
  
  validates :school_id, presence: true
  validates :tipo, presence: true
  validates :periodo, presence: true, uniqueness: { scope: [:school_id, :tipo], message: "Ya se ha facturado este período para esta Escuela" }
  validates :limite_grp_1, presence: true
  validates :valor_1, presence: true, :numericality => true
  validates :valor_2, presence: true, :numericality => true, if: "limite_grp_2 != nil"
  validates :valor_3, presence: true, :numericality => true, if: "limite_grp_3 != nil"
  validates :limite_grp_2, presence: true, if: "limite_grp_1 != nil && limite_grp_1 < " + Child::GRADOS['7mo Grado'].to_s
  validates :limite_grp_3, presence: true, if: "limite_grp_2 != nil && limite_grp_2 < " + Child::GRADOS['7mo Grado'].to_s  


  TIPOS_FACTURACION = {
    'Mensual' => 1,
    'Diaria'  => 2
  }

  def humanized_tipo_facturacion
    TIPOS_FACTURACION.invert[self.tipo]
  end

  def humanized_limite_grp_1
    Child::GRADOS.invert[self.limite_grp_1]
  end

  def humanized_limite_grp_2
    Child::GRADOS.invert[self.limite_grp_2]
  end

  def humanized_limite_grp_3
    Child::GRADOS.invert[self.limite_grp_3]
  end  


  private

  def check_limites
    errors.add(:limite_grp_2, "El valor debe ser mayor al Límite de Grupo 1") if limite_grp_1.present? && limite_grp_2.present? && limite_grp_2 <= limite_grp_1
    errors.add(:limite_grp_3, "El valor debe ser mayor al Límite de Grupo 2") if limite_grp_2.present? && limite_grp_3.present? && limite_grp_3 <= limite_grp_2
  end
end