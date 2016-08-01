class Family < ActiveRecord::Base
  belongs_to :school
  belongs_to :user
  has_many   :children
  has_many   :comments
  has_many   :movements

  validates :apellido, presence: true

  def get_saldo
    return self.movements.sum(:monto)
  end
  
  def hijo_menor
    return self.children.order(grado: :ASC, division: :ASC).first
  end
  
  def ultima_factura
    return self.movements.where("tipo = " + Movement::TIPO_TIPOS['Comedor'].to_s).order(created_at: :DESC).first
  end 
  
  def saldo_previo_ult_factura
    return get_saldo - ultima_factura.monto
  end
  
  def tiene_hijos?
    return self.children.length > 0 ? true : false
  end
end
