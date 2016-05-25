class FamiliesController < ApplicationController
  before_action :authenticate_user!

  def index
    @families = Family.all
  end

end
