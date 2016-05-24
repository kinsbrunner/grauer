class SchoolsController < ApplicationController
  before_action :authenticate_user!

  def index
    @schools = School.all
    @dummy = School.new
  end

  def create
    session[:current_school] = school_params
    redirect_to root_path
  end


  private

  def school_params
    params.require(:school).permit(:name)
  end
end
