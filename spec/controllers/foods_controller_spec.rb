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
end
