class FamiliesController < ApplicationController
  before_action :authenticate_user!

  def index
    @families = Family.order(:apellido).page(params[:page])
  end

end
