class SchoolsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @schools = School.order(:name)
  end
end
