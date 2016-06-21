class MenusController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  
  def index
    @foods_p = Food.where("tipo = "+ Food::TIPO_COMIDAS['Principal'].to_s).order(:comida)
    @foods_a = Food.where("tipo = "+ Food::TIPO_COMIDAS['Acompañamiento'].to_s).order(:comida)
  end
end
