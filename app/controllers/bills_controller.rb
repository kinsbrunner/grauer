class BillsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]
  
  def index
    @bills_monthly = current_school.bills.where("tipo = "+ Bill::TIPOS_FACTURACION['Mensual'].to_s).order(:periodo).page(params[:page])
    #@bills_daily = current_school.bills.where("tipo = "+ Bill::TIPOS_FACTURACION['Diaria'].to_s).order(:periodo).page(params[:page])
  end

  def new
    @bill = Bill.new
  end
  
  def create
    @bill = current_school.bills.create(bill_params)
    if @bill.valid?
      redirect_to bills_path
    else
      switch_fechas
      render :new, status: :unprocessable_entity
    end
  end


  private 

  def bill_params
    valid = params.require(:bill).permit(:tipo, :periodo, :limite_grp_1, :valor_1, :limite_grp_2, :valor_2, :limite_grp_3, :valor_3, :periodo_hidden)
    fecha_aux = valid[:periodo]
    valid[:periodo] = valid[:periodo_hidden]
    valid[:periodo_hidden] = fecha_aux
    return valid
  end

  def switch_fechas
    valid = params.require(:bill).permit(:periodo, :periodo_hidden)
    fecha_aux = valid[:periodo]
    valid[:periodo] = valid[:periodo_hidden]
    valid[:periodo_hidden] = fecha_aux
    return valid
  end
  
  helper_method :current_school
  def current_school
    @current_school ||= School.find_by_id(session[:school_id])
  end  
end
