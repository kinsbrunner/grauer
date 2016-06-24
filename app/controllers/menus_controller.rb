class MenusController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create, :destroy]
  
  def index
    @foods_p = Food.where("tipo = "+ Food::TIPO_COMIDAS['Principal'].to_s).order(:comida)
    @foods_a = Food.where("tipo = "+ Food::TIPO_COMIDAS['Acompañamiento'].to_s).order(:comida)

    @menus = current_school.menus.order(:fecha)
    respond_to do |format|
     format.html # index.html.erb
     format.json { render json: @menus }
    end
  end

  def create
    @menu = current_school.menus.new(menu_params.merge(user: current_user))
    if @menu.save
      render :json => { } # send back any data if necessary
    else
      render :json => { }, :status => 500
    end
  end

  def destroy
    return render_not_found if current_menu.blank?
    current_menu.destroy
    redirect_to menus_path
  end
  

  private

  helper_method :current_menu
  def current_menu
    @current_menu ||= Menu.find_by_id(params[:id])
  end

  helper_method :current_school
  def current_school
    @current_school ||= School.find_by_id(session[:school_id])
  end  

  def menu_params
    params.require(:menu).permit(:fecha, :food_ids => [])
  end
end
