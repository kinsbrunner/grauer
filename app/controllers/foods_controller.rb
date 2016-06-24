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
    @food ||= Food.find_by_id(params[:id])
  end

  def update
    current_food.update_attributes(food_params)
    redirect_to foods_path
  end
  
  def destroy
    return render_not_found if current_food.blank?
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
