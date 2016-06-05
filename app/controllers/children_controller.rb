class ChildrenController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

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

  private
  
  def child_params
    params.require(:child).permit(:nombre, :grado, :division, :tipo_servicio, :comentario)
  end

  helper_method :current_family
  def current_family
    @current_family ||= Family.find_by_id(params[:family_id])
  end
end
