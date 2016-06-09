class FoodsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :destroy]
  
  def index
    @foods = Food.order(:comida).page(params[:page])
  end
  
  def new
    @food = Food.new
  end
  
  def create
    @food = current_food.create(food_params)
    if @food.valid?
      redirect_to foods_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    return render_not_found if current_food.blank?
    current_food.destroy
    redirect_to foods_path
  end
  
    
  private
  
  def food_params
      params.require(:food).permit(:tipo, :comida, :siempre)
  end
  
  helper_method :current_food
  def current_food
    @current_food ||= Food.find_by_id(params[:id])
  end
end
