require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "users#index action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @user_admin = FactoryGirl.create(:user_admin)
    end
    
    it "should successfully show the page if user has Admin rights" do
      sign_in @user_admin
      
      get :index
      expect(response).to have_http_status(:success)
    end

    it "should require users to be logged in" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
    
    it "should require users to have Admin rights" do
      sign_in @user

      get :index
      expect(response).to have_http_status(:forbidden)
    end
  end
end