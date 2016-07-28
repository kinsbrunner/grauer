require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  describe "foods#index action" do
    it "should successfully show the page" do
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
  
  describe "foods#new action" do
    it "should successfully show the new form" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      get :new
      expect(response).to have_http_status(:success)
    end
    
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end    
  end
  
  describe "foods#create action" do
    it "should successfully create a food in our database" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      post :create, food: {comida: 'Milanesa', tipo: 1}
      expect(response).to redirect_to foods_path
      
      food = Food.last
      expect(food.comida).to eq('Milanesa')
      expect(food.tipo).to eq 1
    end
    
    it "should properly deal with valdation errors" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      post :create, food: {comida: ''}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Food.count).to eq 0
    end
    
    it "should require users to be logged in" do
      post :create, food: {comida: 'Milanesa', tipo: 1}
      expect(response).to redirect_to new_user_session_path
    end
  end
  
  describe "foods#edit action" do
    it "should successfully show the edit form if the food is found" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      f = FactoryGirl.create(:food)
      get :edit, id: f.id
      expect(response).to have_http_status(:success)
    end
    
    it "should return a 404 error message if the gram is not found" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      get :edit, id: 'BLABLABLA'
      expect(response).to have_http_status(:not_found)      
    end
    
    it "should require users to be logged in" do
      f = FactoryGirl.create(:food)
      get :edit, id: f.id
      expect(response).to redirect_to new_user_session_path
    end
  end
  
  describe "foods#update action" do
    it "should allow users to successfully update a food" do
      f = FactoryGirl.create(:food, comida: "Initial Value")
      
      user = FactoryGirl.create(:user)
      sign_in user
      
      patch :update, id: f.id, food: {comida: "Changed"}
      expect(response).to redirect_to foods_path
      f.reload
      expect(f.comida).to eq "Changed"
    end
    
    it "should have HTTP 404 error message if the food cannot be found" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      patch :update, id: "BLABLABLA", food: {comida: "Changed"}
      expect(response).to have_http_status(:not_found)
    end
    
    it "should render the edit form with an http status of unprocessable_entity" do
      f = FactoryGirl.create(:food, comida: "Initial Value")
      
      user = FactoryGirl.create(:user)
      sign_in user
      
      patch :update, id: f.id, food: {comida: ""}
      expect(response).to have_http_status(:unprocessable_entity)
      f.reload
      expect(f.comida).to eq "Initial Value"
    end
    
    it "should require users to be logged in" do
      f = FactoryGirl.create(:food, comida: "Initial Value")
      
      patch :update, id: f.id, food: {comida: "Changed"}
      expect(response).to redirect_to new_user_session_path   
    end    
  end
  
  describe "foods#destroy action" do
    
  end
end
