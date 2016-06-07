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
  
  TIPO_DESCUENTOS = {
    '0 %'   => 0.00,      
    '5 %'   => 0.05,      
    '10 %'  => 0.10,      
    '15 %'  => 0.15,      
    '20 %'  => 0.20,      
    '25 %'  => 0.25,      
    '30 %'  => 0.30,      
    '35 %'  => 0.35,      
    '40 %'  => 0.40,      
    '45 %'  => 0.45,      
    '50 %'  => 0.50,      
    '55 %'  => 0.55,      
    '60 %'  => 0.60,      
    '65 %'  => 0.65,      
    '70 %'  => 0.70,      
    '75 %'  => 0.75,      
    '80 %'  => 0.80,      
    '85 %'  => 0.85,      
    '90 %'  => 0.90,      
    '95 %'  => 0.95,      
    '100 %' => 1.00      
  }
  

  def humanized_tipo
    TIPO_TIPOS.invert[self.tipo]
  end
  
  def humanized_forma
    TIPO_FORMAS.invert[self.forma]
  end
  
  def humanized_descuento
    TIPO_DESCUENTOS.invert["%.2f" % BigDecimal(self.descuento).truncate(2)] 
  end
end
