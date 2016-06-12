class Bill < ActiveRecord::Base
  belongs_to :school
  belongs_to :user

  validates :school_id, presence: true
  validates :tipo, presence: true
  validates :periodo, presence: true
  validates :limite_grp_1, presence: true
  validates :valor_1, presence: true, :numericality => true
  validates :limite_grp_2, presence: true, if: "limite_grp_1 < Child::GRADOS['7mo Grado']"
  validates :valor_2, :numericality => true, if: "limite_grp_2 != ''"
  validates :limite_grp_3, presence: true, if: "limite_grp_2 < Child::GRADOS['7mo Grado']"
  validates :valor_3, :numericality => true, if: "limite_grp_3 != ''"


  TIPO_TIPOS_FACTURACION = {
    'Mensual' => 1,
    'Diaria'  => 2
  }

  def humanized_tipo_facturacion
    TIPO_TIPOS_FACTURACION.invert[self.tipo]
  end
end
