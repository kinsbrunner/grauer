class FamiliesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :show, :edit, :update]
  before_action :family_belongs_school, only: [:show, :edit, :update]
  
  def index
    # Si no tengo el SCHOOL_ID redirecciona a la página para elegirlo
    if !params[:school_id]
      redirect_to schools_path
    end

    return render_not_found if current_school.blank?
    session[:school_id] = current_school.id
    @families = current_school.families.order(activo: :DESC, apellido: :ASC)
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
    @children = current_family.children.order(grado: :DESC, division: :ASC, nombre: :ASC)
    @comments = current_family.comments.order(created_at: :DESC).all
    @comment  = Comment.new
    @movements = current_family.movements.order(:created_at)
    
    @total = 0
    @movements.each do |mov|
      @total = @total + mov.monto
      mov.saldo = @total
    end
  end

  def edit    
    return render_not_found if current_family.blank?
  end

  def update
    return render_not_found if current_family.blank?
    current_family.update_attributes(family_params)
    if current_family.valid?
      redirect_to school_family_path(current_school, current_family)
    else
      render :edit, status: :unprocessable_entity
    end     
  end


  private

  def family_params
    params.require(:family).permit(:apellido, :contacto_1, :contacto_2, :tel_cel, :tel_casa, :tel_alt, :email, :direccion, :activo)
  end

  def family_belongs_school      
    if !current_family || current_family.school != current_school
      return render text: 'No relation', status: :not_found
    end
  end

  helper_method :current_family
  def current_family
    @current_family ||= Family.find_by_id(params[:id])
  end
end