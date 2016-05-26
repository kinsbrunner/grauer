class SchoolsController < ApplicationController
  before_action :authenticate_user!

  def index
    @schools = School.all
    @dummy = School.new
  end

  def create

    session[:current_school] = school_params['id']
    redirect_to root_path
  end


  private

  def school_params
    params.require(:school).permit(:id)
  end
end
