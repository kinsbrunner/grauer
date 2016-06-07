class Movement < ActiveRecord::Base
  belongs_to :family
  belongs_to :user
  
  validates :tipo, presence: true
  validates :monto, presence: true
  validates :descuento, presence: true
  
  TIPO_TIPOS = {
    'Servicio'        => 1,
    'Pago'            => 2,
    'Descuento'       => 3,
    'Nota de Crédito' => 4
  }
  
  TIPO_FORMAS = {
    'Efectivo'       => 1,
    'Transferencia'  => 2,
    'Cheque'         => 3,
  }
  

  def humanized_tipo
    TIPO_TIPOS.invert[self.tipo]
  end
  
  def humanized_forma
    TIPO_FORMAS.invert[self.forma]
  end  
end
