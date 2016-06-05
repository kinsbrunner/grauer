class Child < ActiveRecord::Base
  belongs_to :family

  validates :nombre, presence: true
  validates :grado, presence: true
  validates :tipo_servicio, presence: true

  TIPO_SERVICIOS = {
    '1' => 'Mensual',
    '2' => 'Diario'
  }

  GRADOS = {
    '1'  => 'Maternal',
    '2'  => 'Sala de 2',
    '3'  => 'Sala de 3',
    '4'  => 'Sala de 4',
    '5'  => 'Sala de 5',
    '6'  => '1er Grado',
    '7'  => '2do Grado',
    '8'  => '3er Grado',
    '9'  => '4to Grado',
    '10' => '5to Grado',
    '11' => '6to Grado',
    '12' => '7mo Grado'
  }

  def humanized_tipo_serv
    TIPO_SERVICIOS.invert[self.tipo_servicio]
  end

  def humanized_grado
    GRADOS.invert[self.grado]
  end
end
