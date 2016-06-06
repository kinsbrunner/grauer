class Movement < ActiveRecord::Base
  belongs_to :family
  belongs_to :user
  
  validates :fecha, presence: true
  validates :tipo, presence: true
  validates :monto, presence: true
  validates :descuento, presence: true
  
  TIPO_TIPOS = {
    'Servicio'   => 1,
    'Pago'       => 2,
    'Descuento'  => 3
  }
  
  TIPO_FORMAS = {
    'Efectivo'       => 1,
    'Transferencia'  => 2,
    'Cheque'         => 3,
  }
  

  def humanized_tipos
    TIPO_TIPOS.invert[self.tipo]
  end
  
  def humanized_formas
    TIPO_FORMAS.invert[self.formas]
  end  
end
