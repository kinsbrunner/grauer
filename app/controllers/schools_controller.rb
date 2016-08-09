class SchoolsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]
  before_action :check_admin, only: [:new, :create]
  
  def index
    @schools = School.order(:name)
  end
  
  def new
    @school = School.new
  end
  
  def create
    @school = School.create(school_params)
    if @school.valid?
      redirect_to schools_path
    else
      render :new, status: :unprocessable_entity
    end    
  end
  
  def check_admin
    if !current_user.admin
      return render text: 'Not Allowed', status: forbidden
    end
  end

  
  private
  
  def school_params
    params.require(:school).permit(:name)
  end
end
