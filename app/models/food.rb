class Food < ActiveRecord::Base
  validates :tipo, presence: true
  validates :comida, presence: true
  
  TIPO_COMIDAS = {
    'Principal'      => 1,
    'Acompañamiento' => 2
  }


  def humanized_tipo
    TIPO_COMIDAS.invert[self.tipo]
  end
end
