require 'rails_helper'
require 'pp'

RSpec.describe FamiliesController, type: :controller do
  describe "families#index action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @school = FactoryGirl.create(:school)
    end
    
    it "should successfully show the page" do
      sign_in @user
      
      get :index, school_id: @school
      expect(response).to have_http_status(:success)
    end
    
    it "should require users to be logged in" do
      get :index, school_id: @school
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "families#new action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @school = FactoryGirl.create(:school)
    end
    
    it "should successfully show the new form" do
      sign_in @user
      
      get :new, school_id: @school
      expect(response).to have_http_status(:success)
    end
    
    it "should require users to be logged in" do
      get :new, school_id: @school
      expect(response).to redirect_to new_user_session_path
    end    
  end

  describe "families#create action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @school = FactoryGirl.create(:school)
      @family = FactoryGirl.attributes_for(:family)
    end

    it "should successfully create a family in our database" do
      sign_in @user
      
      expect{post :create, family: @family, school_id: @school}.to change(Family,:count).by(1)
      expect(response).to redirect_to school_families_path(@school)
      
      new_family = Family.last
      expect(new_family.apellido).to eq(@family[:apellido])
    end
    
    it "should properly deal with valdation errors" do
      sign_in @user
      
      @family[:apellido] = ''
      
      expect{post :create, family: @family, school_id: @school}.not_to change(Family,:count)
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
    it "should require users to be logged in" do
      post :create, family: @family, school_id: @school
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "families#edit action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @school = FactoryGirl.create(:school)
      @family = FactoryGirl.create(:family, school_id: @school.id)
    end
    
    it "should successfully show the edit form if the family is found" do
      sign_in @user
      
      get :edit, school_id: @school, id: @family
      expect(response).to have_http_status(:success)
    end
    
    it "should return a 404 error message if the food is not found" do
      sign_in @user
      
      get :edit, id: 'BLABLABLA', school_id: @school
      expect(response).to have_http_status(:not_found)
    end
    
    it "should require users to be logged in" do
      get :edit, id: @family, school_id: @school
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "families#update action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @school = FactoryGirl.create(:school)
      @family = FactoryGirl.create(:family, school_id: @school.id)
    end
    
    it "should allow users to successfully update a family" do
      sign_in @user
      
      patch :update, id: @family, family: FactoryGirl.attributes_for(:family, apellido: "Nuevo"), school_id: @school
      expect(response).to redirect_to school_family_path(@school, @family)
      
      @family.reload
      expect(@family.apellido).to eq "Nuevo"
    end
    
    it "should have HTTP 404 error message if the food cannot be found" do
      sign_in @user
      
      patch :update, id: 'BLABLABLA', family: FactoryGirl.attributes_for(:family, apellido: "Nuevo"), school_id: @school
      expect(response).to have_http_status(:not_found)
    end
    
    it "should render the edit form with an http status of unprocessable_entity" do
      sign_in @user
      
      old_family = @family[:apellido]
      patch :update, id: @family, family: FactoryGirl.attributes_for(:family, apellido: ""), school_id: @school
      expect(response).to have_http_status(:unprocessable_entity)
      
      @family.reload
      expect(@family.apellido).to eq old_family
    end
    
    it "should require users to be logged in" do
      patch :update, id: @family, family: FactoryGirl.attributes_for(:family, apellido: "Nuevo"), school_id: @school
      expect(response).to redirect_to new_user_session_path   
    end    
  end

  describe "families#show action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @school = FactoryGirl.create(:school)
      @family = FactoryGirl.create(:family, school_id: @school.id)
    end
    
    it "should successfully show a family" do
      sign_in @user
      
      get :show, id: @family, school_id: @school
      expect(response).to have_http_status(:success)
    end    
    
    it "should require users to be logged in" do
      get :show, id: @family, school_id: @school
      expect(response).to redirect_to new_user_session_path
    end
  end
end
