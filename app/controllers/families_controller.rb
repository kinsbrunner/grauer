class FamiliesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :show]

  def index
    # Si no tengo el SCHOOL_ID redirecciona a la página para elegirlo
    if !params[:school_id]
      redirect_to schools_path
    end

    # Si meten un ID que no existe o un caracter extraño, tira error
    return render_not_found if current_school.blank?

    @families = current_school.families.order(:apellido).page(params[:page])
  end

  def new
    @family = Family.new
  end

  def create
    @family = current_school.families.create(family_params.merge(user: current_user))
    if @family.valid?
      redirect_to school_families_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @family = Family.find_by_id(params[:id])
  end


  private
    helper_method :current_school
    def current_school
      @current_school ||= School.find_by_id(params[:school_id])
    end

    def family_params
      params.require(:family).permit(:apellido, :contacto_1, :contacto_2, :tel_cel, :tel_casa, :tel_fijo, :email, :direccion)
    end
end