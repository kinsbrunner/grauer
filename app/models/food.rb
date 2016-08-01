class Food < ActiveRecord::Base 
  has_many :menus
  has_many :schools, through: :menus

  validates :tipo, presence: true
  validates :comida, presence: true
  
  TIPO_COMIDAS = {
    'Ensalada'              => 0,
    'Principal'             => 1,
    'Acompañamiento'        => 2,
    'Feriados/Festividades' => 3
  }


  def humanized_tipo
    TIPO_COMIDAS.invert[self.tipo]
  end
end
