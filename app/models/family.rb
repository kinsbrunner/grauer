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
  
  def ultima_factura_mensual
    curr_month = Date.today.beginning_of_month
    return self.movements.joins(:bill).where(:bills => {:tipo => Bill::TIPOS_FACTURACION['Mensual'], :periodo => curr_month}).first
  end 
  
  def ultima_factura_diaria
    curr_month = Date.today.beginning_of_month
    prev_month = Date.today.ago(1.month).beginning_of_month
    if Date.today.ago(1.month).beginning_of_month.month != 12  # Diciembre
      return self.movements.joins(:bill).where(:bills => {:tipo => Bill::TIPOS_FACTURACION['Diaria'], :periodo => prev_month}).first
    else
      factura = self.movements.joins(:bill).where(:bills => {:tipo => Bill::TIPOS_FACTURACION['Diaria'], :periodo => curr_month}).first
      if factura.nil?
        return self.movements.joins(:bill).where(:bills => {:tipo => Bill::TIPOS_FACTURACION['Diaria'], :periodo => prev_month}).first
      else
        return factura
      end
    end
  end 
  
  def saldo_previo_ult_factura
    return get_saldo - ultima_factura.monto
  end
  
  def tiene_hijos?
    return self.children.length > 0 ? true : false
  end
end
