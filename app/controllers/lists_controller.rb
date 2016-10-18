class ListsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  
# LIST ID 1: Familias Deudoras para Escuela
# LIST ID 2: Ingresos por Escuela (independiente de la Escuela logueada)
# LIST ID 3: Alumnos de Escuela
  
  def show
    @reporte_id = params[:id]
    if @reporte_id == '1'
      
      @families = current_school.families.order(activo: :DESC, apellido: :ASC)
      
    elsif @reporte_id == '2'
      
      @schools = School.order(:name)
      @months = 1..12
      @incomes = Movement.select("extract(year from created_at) as anio, extract(month from created_at) as mes, school_id, sum(monto) as income").where("tipo = 1 AND extract(year from created_at) >= (date_part('year', CURRENT_DATE)-1)").group("anio, mes, school_id")  
      @ingresos = Hash.new
      @schools.each do |s|
        @ingresos[s.name] = Hash.new
        
        # Año actual
        @ingresos[s.name][Date.today.year] = Hash.new
        @months.each do |mes|
          @ingresos[s.name][Date.today.year][mes] = 0
        end
        # Año anterior
        @ingresos[s.name][Date.today.year-1] = Hash.new
        @months.each do |mes|
          @ingresos[s.name][Date.today.year-1][mes] = 0
        end
      end
      @incomes.each do |inc|
        @ingresos[inc.school.name][inc.anio.to_i][inc.mes.to_i] = -inc.income
      end
      
      #Calculo TOTAL por Escuela - Año actual
      @schools.each do |s|
        total = 0
        @months.each do |mes|
          total = total + @ingresos[s.name][Date.today.year][mes]
        end
        @ingresos[s.name][Date.today.year]['total'] = total
      end

      #Calculo TOTAL por Escuela - Año anterior
      @schools.each do |s|
        total = 0
        @months.each do |mes|
          total = total + @ingresos[s.name][Date.today.year-1][mes]
        end
        @ingresos[s.name][Date.today.year-1]['total'] = total
      end      
      
    elsif @reporte_id == '3'
    
      @students = current_school.children
    
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
