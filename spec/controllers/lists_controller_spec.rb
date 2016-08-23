require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  describe "lists#show action" do
    before :each do
      @school = FactoryGirl.create(:school)
    end
    
    it "should successfully show report 1" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      get :show, school_id: @school, id: 1
      expect(response).to have_http_status(:success)
    end

    it "should successfully show report 2" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      get :show, school_id: @school, id: 2
      expect(response).to have_http_status(:success)
    end
    
    it "should successfully show report 3" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      get :show, school_id: @school, id: 3
      expect(response).to have_http_status(:success)
    end    
    
    it "should require users to be logged in" do
      get :show, school_id: @school, id: 1
      expect(response).to redirect_to new_user_session_path
    end
  end
end
