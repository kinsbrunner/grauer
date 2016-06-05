class ChildrenController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def new
    @child = Child.new
  end

  def create
    @child = current_family.children.create(child_params)
    if @child.valid?
      redirect_to school_family_path(current_school, current_family)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    current_child.update_attributes(child_params)
    redirect_to school_family_path(current_school, current_family)
  end

  def destroy
    return render_not_found if current_child.blank?
    current_child.destroy
    redirect_to school_family_path(current_school, current_family)
  end

  private
  
  def child_params
    params.require(:child).permit(:nombre, :grado, :division, :tipo_servicio, :comentario)
  end

  helper_method :current_family
  def current_family
    @current_family ||= Family.find_by_id(params[:family_id])
  end

  helper_method :current_child
  def current_child
    @current_child ||= Child.find_by_id(params[:id])
  end
end
