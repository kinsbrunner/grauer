class ListsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  
# LIST ID 1: Familias Deudoras para Escuela
# LIST ID 1: Ingresos por Escuela (independiente de la Escuela logueada)
  
  def show
    reporte_id = params[:id]
    if reporte_id == '1'
      @families = current_school.families.order(:apellido).page(params[:page])
    elsif reporte_id == '2'

    else
      return render_not_found
    end
  end
  
  
  private
  
  helper_method :current_school
  def current_school
    @current_school ||= School.find_by_id(params[:school_id])
  end
end
