class BillsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :destroy, :edit, :update]


  def index
    @tipo = params[:tipo]
    if @tipo == Bill::TIPOS_FACTURACION['Mensual'].to_s
      @bills = current_school.bills.where("tipo = #{Bill::TIPOS_FACTURACION['Mensual'].to_s}").order(:periodo).page(params[:page])
    elsif @tipo == Bill::TIPOS_FACTURACION['Diaria'].to_s
      @bills = current_school.bills.where("tipo = #{Bill::TIPOS_FACTURACION['Diaria'].to_s}").order(:periodo).page(params[:page])
    else
      return render_not_found
    end
  end

  def new
    @bill = Bill.new
    @tipo = params[:tipo]
    if @tipo == Bill::TIPOS_FACTURACION['Diaria'].to_s
      @children = current_school.children.where(tipo_servicio: Child::TIPO_SERVICIOS['Diario'])
      @children.each do |child|
        @menu_day = @bill.menu_day.new
        @menu_day.child = child
      end
    end
  end
  
  def create
    @tipo = params[:bill][:tipo]
    Bill.transaction do   
      @bill = current_school.bills.create(bill_params.merge(user: current_user))
      if @bill.valid?
        generate_movements(@bill, @tipo)
        redirect_to school_bills_path(tipo: @tipo)
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def destroy
    return render_not_found if current_bill.blank?
    @tipo = params[:tipo]
    current_bill.destroy
    redirect_to school_bills_path(tipo: @tipo)
  end

  def edit
  end
  
  def update
  end
  
  
  private 

  def bill_params
    params.require(:bill).permit(:tipo, :periodo, :limite_grp_1, :valor_1, :limite_grp_2, :valor_2, :limite_grp_3, :valor_3, :menu_day_attributes => [:child_id, :cantidad])
  end
  
  helper_method :current_school
  def current_school
    @current_school ||= School.find_by_id(session[:school_id])
  end  

  helper_method :current_bill
  def current_bill
    @current_bill ||= Bill.find_by_id(params[:id])
  end  

  def generate_movements(factura, tipo)
    families = Family.where(school_id: current_school, activo: true)
    families.each do |family|
      comps = Array.new
      total = 0
      detalle = ''
      if tipo == Bill::TIPOS_FACTURACION['Mensual'].to_s
        children = Child.where(family_id: family, tipo_servicio: Child::TIPO_SERVICIOS['Mensual'])
        detalle = "Componentes de factura mensual: "
      else
        children = Child.where(family_id: family, tipo_servicio: Child::TIPO_SERVICIOS['Diario'])
        detalle = "Componentes de factura diaria: "
      end
      if children.length > 0
        children.each do |child|
          if tipo == Bill::TIPOS_FACTURACION['Mensual'].to_s
            if child.grado <= factura.limite_grp_1
              comps << factura.valor_1.to_i
            elsif child.grado <= factura.limite_grp_2
              comps << factura.valor_2.to_i
            else
              comps << factura.valor_3.to_i
            end
          else
            day = params[:bill][:menu_day_attributes].find {|md| md['child_id'] == child.id.to_s }
            cant = day['cantidad'].to_i
            if child.grado <= factura.limite_grp_1
              comps << factura.valor_1.to_i * cant
            elsif child.grado <= factura.limite_grp_2
              comps << factura.valor_2.to_i * cant
            else
              comps << factura.valor_3.to_i * cant
            end            
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
          mov.do_forma_validation = true
          mov.save!
        end
      end
    end
  end

end