class BillsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]


  def index
    @bills_monthly = current_school.bills.where("tipo = "+ Bill::TIPOS_FACTURACION['Mensual'].to_s).order(:periodo).page(params[:page])
  end

  def new
    @bill = Bill.new
  end
  
  def create   
    @bill = current_school.bills.create(bill_params.merge(user: current_user))
    if @bill.valid?
      generate_movements(@bill)
      redirect_to bills_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  private 

  def bill_params
    params.require(:bill).permit(:tipo, :periodo, :limite_grp_1, :valor_1, :limite_grp_2, :valor_2, :limite_grp_3, :valor_3)
  end
  
  helper_method :current_school
  def current_school
    @current_school ||= School.find_by_id(session[:school_id])
  end  

  def generate_movements(factura)
    families = Family.where(school_id: current_school)
    families.each do |family|
      comps = Array.new
      total = 0
      detalle = ''
      children = Child.where(family_id: family, tipo_servicio: Child::TIPO_SERVICIOS['Mensual'])
      children.each do |child|
        if detalle.empty?
          detalle = 'Componentes de factura: '
        end

        if child.grado <= factura.limite_grp_1
          comps << factura.valor_1
        elsif child.grado <= factura.limite_grp_2
          comps << factura.valor_2
        else
          comps << factura.valor_3
        end
      end

      total = comps.inject(0){|sum, x| sum + x.to_i }
      detalle = comps.join(' + ')

      if total > 0
        mov           = Movement.new
        mov.family_id = family.id
        mov.user_id   = current_user.id
        mov.bill_id   = factura.id
        mov.tipo      = Movement::TIPO_TIPOS['Servicio']
        mov.monto     = total
        mov.nota      = detalle 
        mov.save
      end
    end
  end

end