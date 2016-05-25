class FamiliesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @families = Family.order(:apellido).page(params[:page])
    @flia = Family.new
  end

  def create
    @family = Family.create(family_params)
    #curent_school.families.create(family_params)
    if @family.valid?
      redirect_to families_path
    else
      render :index, status: :unprocessable_entity
    end
    
  end


  private

    def family_params
      params.require(:family).permit(:apellido, :contacto_1, :contacto_2, :tel_cel, :tel_casa, :tel_fijo, :email, :direccion)
    end
end
