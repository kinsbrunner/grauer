require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do
  describe "static_pages#index action" do
    it "should enter into the site" do
      user = FactoryGirl.create(:user)
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end

    it "should require users to be logged in" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end
end
