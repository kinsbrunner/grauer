class FamiliesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    if session[:current_school].nil?
      redirect_to schools_path
    end

    @families = Family.order(:apellido).page(params[:page])
    @flia = Family.new
  end

  def create
    @school = School.find_by_id(session[:current_school]['id'])
    @family = @school.families.create(family_params)
    if @family.valid?
      redirect_to families_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

    def family_params
      params.require(:family).permit(:apellido, :contacto_1, :contacto_2, :tel_cel, :tel_casa, :tel_fijo, :email, :direccion)
    end
end
