class MovementsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  
  def new
    @movement = Movement.new
  end
  
  def create
    @movement = current_family.movements.new(movement_params.merge(user: current_user, school: current_school))
    
    if @movement.tipo == Movement::TIPO_TIPOS['Pago'] 
      @movement.do_forma_validation = false
    else
      @movement.do_forma_validation = true
    end  
    
    if @movement.save
      redirect_to school_family_path(current_school, current_family)
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    return render_not_found if current_movement.blank?
    current_movement.destroy
    redirect_to school_family_path(current_school, current_family)
  end
  
  
  private
  
  def movement_params
    params.require(:movement).permit(:tipo, :monto, :saldo, :forma, :descuento, :nota)
  end 

  helper_method :current_school
  def current_school
    @current_school ||= School.find_by_id(params[:school_id])
  end  
  
  helper_method :current_family
  def current_family
    @current_family ||= Family.find_by_id(params[:family_id])
  end

  helper_method :current_movement
  def current_movement
    @current_movement ||= Movement.find_by_id(params[:id])
  end  
end
