class EvolutionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  
  def index
    @evolutions = current_school.evolutions.order(created_at: :DESC).page(params[:page])
  end
  
  def create
    @evolution = current_school.evolutions.create(school: current_school, user: current_user)
    if @evolution.valid?
      alumnos = current_school.children
      alumnos.each do |alumno|
        alumno.pasar_grado(current_user)
      end
    end
    redirect_to school_evolutions_path
  end
  
  
  private
  
  helper_method :current_school
  def current_school
    @current_school ||= School.find_by_id(session[:school_id])
  end  
end
