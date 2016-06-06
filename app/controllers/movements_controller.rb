class MovementsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  
  def new
    @movement = Movement.new
  end
  
  def create
    @movement = current_family.movements.create(movement_params.merge(user: current_user))
    if @movement.valid?
      redirect_to school_family_path(current_school, current_family)
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  
  private
  
  def movement_params
    params.require(:child).permit(:fecha, :tipo, :monto, :saldo, :forma, :descuento, :nota)
  end
  
  helper_method :current_family
  def current_family
    @current_family ||= Family.find_by_id(params[:family_id])
  end

  helper_method :current_child
  def current_child
    @current_child ||= Child.find_by_id(params[:id])
  end  
end
