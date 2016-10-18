class BillsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :destroy, :edit, :update]
  before_action :check_is_diaria, only: [:edit, :update]


  def index
    return render_not_found if current_school.blank?
    
    @tipo = params[:tipo]
    if @tipo == Bill::TIPOS_FACTURACION['Mensual'].to_s
      @bills = current_school.bills.where("tipo = #{Bill::TIPOS_FACTURACION['Mensual'].to_s}").order(:periodo)
    elsif @tipo == Bill::TIPOS_FACTURACION['Diaria'].to_s
      @bills = current_school.bills.where("tipo = #{Bill::TIPOS_FACTURACION['Diaria'].to_s}").order(:periodo)
    else
      return render_not_found
    end
  end

  def new
    return render_not_found if current_school.blank?
    @bill = Bill.new
    @tipo = params[:tipo]
    if @tipo == Bill::TIPOS_FACTURACION['Diaria'].to_s
      @children = current_school.children.where(tipo_servicio: Child::TIPO_SERVICIOS['Diario']).joins(:family).order('families.apellido asc', 'children.nombre asc')
      @children.each do |child|
        @menu_day = @bill.menu_day.new
        @menu_day.child = child
      end
    end
  end
  
  def create
    return render_not_found if current_school.blank?
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
    return render_not_found if current_school.blank?
    return render_not_found if current_bill.blank?
    @tipo = params[:tipo]
    current_bill.destroy
    redirect_to school_bills_path(tipo: @tipo)
  end

  def edit
    return render_not_found if current_school.blank?
    return render_not_found if current_bill.blank?
    @tipo = params[:tipo]
    @bill = current_bill
    menu_day_attributes = @bill.menu_day
  end
  
  def update
    return render_not_found if current_school.blank?
    return render_not_found if current_bill.blank?
    @tipo = params[:bill][:tipo]
    @bill = current_bill
    
    Bill.transaction do
      @bill.update_attributes(bill_params)
      if @bill.valid?
        @bill.movements.destroy_all
        generate_movements(@bill, @tipo)
        redirect_to school_bills_path(tipo: @bill.tipo)
      else
        @bill.errors.full_messages.each do |message|
          puts message
        end
        render :edit, status: :unprocessable_entity
      end
    end
  end
  
  
  private 

  def bill_params
    params.require(:bill).permit(:tipo, :periodo, :limite_grp_1, :valor_1, :limite_grp_2, :valor_2, :limite_grp_3, :valor_3, :menu_day_attributes => [:id, :bill_id, :child_id, :cantidad])
  end
  
  helper_method :current_school
  def current_school
    #@current_school ||= School.find_by_id(session[:school_id])
    @current_school ||= School.find_by_id(params[:school_id])
  end  

  helper_method :current_bill
  def current_bill
    @current_bill ||= Bill.find_by_id(params[:id])
  end  

  def check_is_diaria
    return render_not_found if current_bill.blank?
    if current_bill.tipo != Bill::TIPOS_FACTURACION['Diaria']
      return render text: 'Not Allowed', status: :forbidden
    end    
  end

  def generate_movements(factura, tipo)
    if tipo == Bill::TIPOS_FACTURACION['Mensual'].to_s
      tipo_servicio = Child::TIPO_SERVICIOS['Mensual']
    else
      tipo_servicio = Child::TIPO_SERVICIOS['Diario']
    end
    
    families = Hash.new
    children = Child.joins(:family).where(families: {school_id: current_school, activo: 'true'}, children: {tipo_servicio: tipo_servicio}).order(:family_id)
    children.each do |child|
      if !families.has_key?(child.family_id)
        families[child.family_id] = Array.new
      end
      
      if tipo == Bill::TIPOS_FACTURACION['Mensual'].to_s
        if child.grado <= factura.limite_grp_1
          families[child.family_id].push(factura.valor_1.to_i)
        elsif child.grado <= factura.limite_grp_2
          families[child.family_id].push(factura.valor_2.to_i)
        else
          families[child.family_id].push(factura.valor_3.to_i)
        end
      else
        if params[:bill][:menu_day_attributes].is_a?(Array) #this case is on CREATE
          day = params[:bill][:menu_day_attributes].find {|md| md['child_id'] == child.id.to_s }
        elsif params[:bill][:menu_day_attributes].is_a?(Hash) #this case is on UPDATE
          params[:bill][:menu_day_attributes].each do |dummy, ch|
            day = ch
            break if ch["child_id"] == child.id.to_s
          end
        end
        cant = day['cantidad'].to_i
        if child.grado <= factura.limite_grp_1
          families[child.family_id].push(factura.valor_1.to_i * cant)
        elsif child.grado <= factura.limite_grp_2
          families[child.family_id].push(factura.valor_2.to_i * cant)
        else
          families[child.family_id].push(factura.valor_3.to_i * cant)
        end
      end
    end

    families.each do |key, comps|
      total = comps.inject(0){|sum, x| sum + x.to_i }
      if tipo == Bill::TIPOS_FACTURACION['Mensual'].to_s
        detalle = "Mensual (#{I18n.t("date.month_names")[factura.periodo.mon]}: "
      else
        detalle = "Diario (#{I18n.t("date.month_names")[factura.periodo.mon]}: "
      end
      detalle += comps.join(' + ')
      detalle += ')'

      if total > 0
        mov           = Movement.new
        mov.family_id = key
        mov.user_id   = current_user.id
        mov.school_id = current_school.id
        mov.bill_id   = factura.id
        mov.tipo      = Movement::TIPO_TIPOS['Comedor']
        mov.monto     = total
        mov.nota      = detalle
        mov.do_forma_validation = true
        mov.save!
      end      
    end
  end  
  
end