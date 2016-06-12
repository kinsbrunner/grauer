class Bill < ActiveRecord::Base
  belongs_to :school
  belongs_to :user

  validates :school_id, presence: true
  validates :tipo, presence: true
  validates :periodo, presence: true
  validates :limite_grp_1, presence: true
  validates :valor_1, presence: true, :numericality => true
  validates :valor_2, :numericality => true
  validates :valor_3, :numericality => true


  TIPO_TIPOS_FACTURACION = {
    'Mensual' => 1,
    'Diaria'  => 2
  }

  def humanized_tipo_facturacion
    TIPO_TIPOS_FACTURACION.invert[self.tipo]
  end
end
