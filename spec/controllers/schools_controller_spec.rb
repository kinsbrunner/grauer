require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do
  describe "schools#index action" do
    it "should show School selection popup" do
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

  describe "schools#create action" do
    it "should set session values for current_school" do
      user = FactoryGirl.create(:user)
      sign_in user
      session[:current_school] = 'ABC'
      post :create, school: {name: 'SCHOOL'}
      session[:current_school] = 'SCHOOL'
      expect(session[:current_school]).to eq('SCHOOL')
      expect(response).to redirect_to root_path
    end

    it "should require users to be logged in" do
      post :create, school: {name: 'SCHOOL'}
      expect(response).to redirect_to new_user_session_path
    end
  end
end
