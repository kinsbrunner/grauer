class MenusController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create, :update, :destroy]
  
  def index
    @foods_p = Food.where("tipo = "+ Food::TIPO_COMIDAS['Principal'].to_s).order(:comida)
    @foods_a = Food.where("tipo = "+ Food::TIPO_COMIDAS['Acompañamiento'].to_s).order(:comida)
  end

  def get_menus
    @menus = current_school.menus.where("fecha >= '#{params['start'].to_s}' and fecha <= '#{params['end'].to_s}'")
    platos = []
    @menus.each do |menu|
      platos << {:id => menu.id, :title => "#{menu.food.comida}", :start => "#{menu.fecha}", :allDay => true }
    end
    render :text => platos.to_json
  end

  def create
    @menu = current_school.menus.new(menu_params.merge(user: current_user))
    if @menu.save
      render :json => { menuId: @menu.id } # send back any data if necessary
    else
      render :json => { }
    end
  end

  def update
    @menu = Menu.where("school_id = :school_id AND food_id = :food_id AND fecha = :fecha", 
      {school_id: current_menu.school_id, food_id: current_menu.food_id, fecha: params[:fecha]})
    if @menu.blank?
      current_menu.update_attribute(:fecha, params[:fecha])
      render :json => { status: 0 }
    else
      render :json => { status: -1 }
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
    params.require(:menu).permit(:fecha, :food_id)
  end 
end
