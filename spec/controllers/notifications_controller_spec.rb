require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  describe "notifications#index action" do
    before :each do
      @school = FactoryGirl.create(:school)
    end
    
    it "should successfully show the page" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      get :index, school_id: @school
      expect(response).to have_http_status(:success)
    end
    
    it "should require users to be logged in" do
      get :index, school_id: @school
      expect(response).to redirect_to new_user_session_path
    end
  end
end
