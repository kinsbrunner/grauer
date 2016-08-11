class School < ActiveRecord::Base
  has_many :families, :dependent => :restrict_with_error
  has_many :children, through: :families, :dependent => :restrict_with_error
  has_many :bills, :dependent => :restrict_with_error
  has_many :movements, :dependent => :restrict_with_error
  has_many :evolutions, :dependent => :restrict_with_error
  has_many :menus, :dependent => :restrict_with_error
  has_many :foods, through: :menus, :dependent => :restrict_with_error
  
  validates :name, presence: true, uniqueness: true

  def ultima_factura_mensual #Se factura por adelantado
    curr_month = Date.today.beginning_of_month
    return self.bills.where(:tipo => Bill::TIPOS_FACTURACION['Mensual'], :periodo => curr_month).first
  end 
  
  def ultima_factura_diaria #Se factura a mes vencido
    prev_month = Date.today.ago(1.month).beginning_of_month
    curr_month = Date.today.beginning_of_month

    if Date.today.ago(1.month).beginning_of_month.month != 12  # Diciembre
      return self.bills.where(:tipo => Bill::TIPOS_FACTURACION['Diaria'], :periodo => prev_month).first
    else
      factura = self.bills.where(:tipo => Bill::TIPOS_FACTURACION['Diaria'], :periodo => curr_month).first
      if factura.nil?
        return self.bills.where(:tipo => Bill::TIPOS_FACTURACION['Diaria'], :periodo => prev_month).first
      else
        return factura
      end
    end
  end 
end
