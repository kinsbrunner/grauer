class Bill < ActiveRecord::Base
  belongs_to :school
  belongs_to :user
  
  attr_accessor :periodo_hidden

  validates :school_id, presence: true
  validates :tipo, presence: true
  validates :periodo, presence: true
  validates :limite_grp_1, presence: true
  validates :valor_1, presence: true, :numericality => true
  validates :limite_grp_2, presence: true, if: "limite_grp_1 < " + Child::GRADOS['7mo Grado'].to_s
  validates :limite_grp_3, presence: true, if: "limite_grp_2 < " + Child::GRADOS['7mo Grado'].to_s
  validates :valor_2, :numericality => true, if: "limite_grp_2 != ''"
#  validates :valor_3, :numericality => true, if: "limite_grp_3 != ''"


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
end

