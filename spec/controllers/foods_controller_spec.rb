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
    before :each do
      @food = FactoryGirl.attributes_for(:food)
    end

    it "should successfully create a food in our database" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      expect{post :create, food: @food}.to change(Food,:count).by(1)
      expect(response).to redirect_to foods_path
      
      new_food = Food.last
      expect(new_food.comida).to eq(@food[:comida])
      expect(new_food.tipo).to eq(@food[:tipo])
    end
    
    it "should properly deal with valdation errors" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      @food[:comida] = ''
      
      expect{post :create, food: @food}.not_to change(Food,:count)
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
    it "should require users to be logged in" do
      post :create, food: @food
      expect(response).to redirect_to new_user_session_path
    end
  end
  
  describe "foods#edit action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @food = FactoryGirl.create(:food)
    end
    
    it "should successfully show the edit form if the food is found" do
      sign_in @user
      
      get :edit, id: @food
      expect(response).to have_http_status(:success)
    end
    
    it "should return a 404 error message if the food is not found" do
      sign_in @user
      
      get :edit, id: 'BLABLABLA'
      expect(response).to have_http_status(:not_found)
    end
    
    it "should require users to be logged in" do
      get :edit, id: @food
      expect(response).to redirect_to new_user_session_path
    end
  end
  
  describe "foods#update action" do
    before :each do
      @food = FactoryGirl.create(:food)
    end
    
    it "should allow users to successfully update a food" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      patch :update, id: @food, food: FactoryGirl.attributes_for(:food, comida: "Hamburguesas", tipo: 2)
      expect(response).to redirect_to foods_path
      
      @food.reload
      expect(@food.comida).to eq "Hamburguesas"
      expect(@food.tipo).to eq 2
    end
    
    it "should have HTTP 404 error message if the food cannot be found" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      patch :update, id: "BLABLABLA", food: FactoryGirl.attributes_for(:food, comida: "LALALA")
      expect(response).to have_http_status(:not_found)
    end
    
    it "should render the edit form with an http status of unprocessable_entity" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      old_comida = @food[:comida]
      patch :update, id: @food, food: FactoryGirl.attributes_for(:food, comida: "")
      expect(response).to have_http_status(:unprocessable_entity)
      
      @food.reload
      expect(@food.comida).to eq old_comida
    end
    
    it "should require users to be logged in" do
      patch :update, id: @food, food: FactoryGirl.attributes_for(:food, comida: "LALALA")
      expect(response).to redirect_to new_user_session_path   
    end    
  end
  
  describe "foods#destroy action" do
    before :each do
      @food = FactoryGirl.create(:food)
    end
    
    it "should successfully delete a food if found" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      expect{delete :destroy, id: @food}.to change(Food, :count).by(-1)
      expect(response).to redirect_to foods_path
      
      f = Food.find_by_id(@food)
      expect(f).to eq nil
    end
  
    it "should return a 404 error message if the food is not found" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      delete :destroy, id: 'BLABLABLA'
      expect(response).to have_http_status(:not_found)
      expect{response}.not_to change(Food,:count)
    end

    it "should require users to be logged in" do
      delete :destroy, id: @food
      expect(response).to redirect_to new_user_session_path
    end
  end
end
