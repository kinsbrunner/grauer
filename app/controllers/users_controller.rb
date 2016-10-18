class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :check_admin, only: [:index]
  
  
  def index
    @users = User.order(:firstname, :lastname)
  end
    
  def check_admin
    if !current_user.admin
      return render text: 'Not Allowed', status: :forbidden
    end
  end

end
