class FoodsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :destroy, :edit, :update]
  
  def index
    @foods = Food.order(:comida).page(params[:page])
    @food = Food.new
  end
  
  def new
    @food = Food.new
  end
  
  def create
    @food = Food.create(food_params)
    if @food.valid?
      redirect_to foods_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    return render_not_found if current_food.blank?
    @food = current_food
  end

  def update
    return render_not_found if current_food.blank?
    current_food.update_attributes(food_params)
    if current_food.valid?
      redirect_to foods_path
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    return render_not_found if current_food.blank?
    
    if current_food.menus.count > 0
      flash[:alert] = "No se puede eliminar la Comida ya que es utilizada en algunos Menúes"
    else  
      flash[:notice] = "Se ha eliminado la Comida satisfactoriamente"
    end
    current_food.destroy
    redirect_to foods_path
  end
  
    
  private
  
  def food_params
    params.require(:food).permit(:tipo, :comida)
  end
  
  helper_method :current_food
  def current_food
    @current_food ||= Food.find_by_id(params[:id])
  end
end
