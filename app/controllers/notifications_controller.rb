class NotificationsController < ApplicationController
  before_action :authenticate_user!, only: [:show]

# NOTIF ID 1: Muestra con calendario del mes actual
# NOTIF ID 2: Muestra con calendario del mes siguiente
  
  def show
    @menus = current_school.menus.order(:fecha)
    @menus_by_date = @menus.group_by(&:fecha)
    @families = current_school.families.where(activo: true).order(:apellido, :contacto_1)
    
    @notif_id = params[:id]
    if @notif_id == '1'
      @date = Date.today
    elsif @notif_id == '2'
      @date = Date.today.at_beginning_of_month.next_month
    else
      return render_not_found      
    end
    
    respond_to do |format|
      format.html
      format.pdf do
        render  :pdf         => "Notificaciones_#{current_school.name}", 
                :template    => 'notifications/show.html.erb',   # Excluding ".pdf" extension.
                :disposition => 'inline',  # 'attachment'
                :orientation => 'portrait', 
                :page_size   => 'A4',
                :title       => "Notificaciones de Escuela #{current_school.name}",
                :margin      =>  {  top:      5,  # default 10 (mm)
                                    bottom:   10,
                                    left:     10,
                                    right:    5 }
      end
    end    
  end  


  private
    helper_method :current_school
    def current_school
      @current_school ||= School.find_by_id(params[:school_id])
    end
end
