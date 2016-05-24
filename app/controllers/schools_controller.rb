class SchoolsController < ApplicationController
  before_action :authenticate_user!

  def edit
    #Acá preparo todo para cuando muestro la vista con el pop-up para que elijan la Escuela con la que van a operar
    @schools = School.all
  end

  def update
    #Acá tomo la Escuela seleccionada y la coloco en una variable de sesión
  end
end
