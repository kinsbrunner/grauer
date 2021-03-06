class Movement < ActiveRecord::Base
  belongs_to :family
  belongs_to :user
  belongs_to :bill
  belongs_to :school

  before_save :adjust_monto
  after_save  :add_descuento

  attr_accessor :saldo
  attr_accessor :do_forma_validation
  
  validates :tipo, presence: true
  validates :monto, presence: true, :numericality => true
  validates :descuento, presence: true
  validates :forma, presence: true, unless: :do_forma_validation
  
  TIPO_TIPOS = {
    'Pago'            => 1,
    'Comedor'         => 2,
    'Nota de Crédito' => 3,
    'Descuento'       => 4
  }

  TIPO_TIPOS_DDLB = {
    'Pago'            => 1,
    'Comedor'         => 2,
    'Nota de Crédito' => 3
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

  def add_descuento
    if self.tipo == TIPO_TIPOS['Pago'] && self.descuento > 0
      mov           = Movement.new
      mov.family_id = self.family_id
      mov.user_id   = self.user_id
      mov.school_id = self.school_id
      mov.tipo      = TIPO_TIPOS['Descuento']
      mov.monto     = (self.monto / (1 - self.descuento)) * self.descuento
      mov.descuento = self.descuento
      mov.nota = "Relacionado con el pago de $#{-(self.monto.to_i)}"
      mov.do_forma_validation = true
      mov.save
      Rails.logger.info(mov.errors.inspect)
    end
  end
  
  
  private  
  
  def adjust_monto
    if tipo == TIPO_TIPOS['Comedor']
      self.monto = self.monto.abs
    else  
      self.monto = -(self.monto.abs)
    end
    
    if self.tipo == TIPO_TIPOS['Pago'] && self.descuento != 0
      self.monto = self.monto * (1 - self.descuento)
    end
  end

end
