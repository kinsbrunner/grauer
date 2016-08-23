require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do
  describe "schools#index action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @user_admin = FactoryGirl.create(:user_admin)
    end
    
    it "should successfully show the page" do
      sign_in @user
      
      get :index
      expect(response).to have_http_status(:success)
    end

    it "should require users to be logged in" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end

    it "should redirect to School creation page if no School exists" do
      sign_in @user_admin
      
      expect(School.count).to eq(0)
      
      get :index
      expect(response).to redirect_to new_school_path
    end    
  end

  describe "schools#new action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @user_admin = FactoryGirl.create(:user_admin)
    end
    
    it "should successfully show the new form" do
      sign_in @user_admin
      
      get :new
      expect(response).to have_http_status(:success)
    end

    it "should not show the new form if user has no Admin rights" do
      sign_in @user
      
      get :new
      expect(response).to have_http_status(:forbidden)
    end    
    
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "schools#create action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @user_admin = FactoryGirl.create(:user_admin)
      @school = FactoryGirl.attributes_for(:school)
    end

    it "should successfully create a school in our database" do
      sign_in @user_admin
      
      expect{post :create, school: @school}.to change(School,:count).by(1)
      expect(response).to redirect_to schools_path
      
      new_school = School.last
      expect(new_school.name).to eq(@school[:name])
    end
    
    it "should require users to be logged in" do
      post :create, school: @school
      expect(response).to redirect_to new_user_session_path
    end

    it "should require users to have Admin rights" do
      sign_in @user

      post :create, school: @school
      expect(response).to have_http_status(:forbidden)
    end    
  end
end