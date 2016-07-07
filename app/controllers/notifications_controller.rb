class NotificationsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  
  def index
    @families = current_school.families.order(:apellido, :contacto_1)

    
    respond_to do |format|
      format.html
      format.pdf do
        render  :pdf         => "Impresiones_#{current_school.name}", 
                :template    => 'notifications/index.html.erb',   # Excluding ".pdf" extension.
                :disposition => 'inline',  # 'attachment'
                :orientation => 'portrait', 
                :page_size   => 'A4',
                :title       => 'TITULITO',
                :margin      =>  {  top:      5,                     # default 10 (mm)
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
