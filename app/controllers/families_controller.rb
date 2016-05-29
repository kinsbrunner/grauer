class FamiliesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]

  def index
    # Si no tengo el SCHOOL_ID redirecciona a la página para elegirlo
    if !params[:school_id]
      redirect_to root_path
    end

    # Si meten un ID que no existe o un caracter extraño, tira error
    return render_not_found if current_school.blank?

    @families = current_school.families.order(:apellido).page(params[:page])
  end


  helper_method :current_school
  def current_school
    @current_school ||= School.find_by_id(params[:school_id])
  end


=begin
  def new
    @familiy = Family.new
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
=end
end