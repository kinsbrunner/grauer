class Child < ActiveRecord::Base
  belongs_to :family
  has_many :menu_day, :dependent => :destroy
  
  validates :nombre, presence: true
  validates :grado, presence: true
  validates :tipo_servicio, presence: true

  TIPO_SERVICIOS = {
    'Mensual' => 1,
    'Diario'  => 2
  }

  GRADOS = {
    'Maternal'  => 1,
    'Sala de 2' => 2,
    'Sala de 3' => 3,
    'Sala de 4' => 4,
    'Sala de 5' => 5,
    '1er Grado' => 6,
    '2do Grado' => 7,
    '3er Grado' => 8,
    '4to Grado' => 9,
    '5to Grado' => 10,
    '6to Grado' => 11,
    '7mo Grado' => 12
  }

  def humanized_tipo_serv
    TIPO_SERVICIOS.invert[self.tipo_servicio]
  end

  def humanized_grado
    GRADOS.invert[self.grado]
  end
  
  def pasar_grado(curr_user)
    if self.grado <= Child::GRADOS['6to Grado']
      self.grado += 1 
      if self.save
        self.family.comments.create(message: "#{self.nombre.to_s} ha pasado a #{self.humanized_grado}", user: curr_user)
      end
    else
      self.egresar_alumno(curr_user)
    end
  end
  
  def egresar_alumno(curr_user)
    if self.destroy
      self.family.comments.create(message: "#{self.nombre.to_s} ha egresado de la escuela", user: curr_user)
    end
  end
  
end