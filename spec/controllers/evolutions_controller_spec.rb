require 'rails_helper'

RSpec.describe EvolutionsController, type: :controller do
  describe "evolutions#index action" do
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
  
  describe "evolutions#create action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @school = FactoryGirl.create(:school)
      @evolution = FactoryGirl.attributes_for(:evolution)
    end

    it "should successfully create an evolution in our database" do
      sign_in @user
      
      qty_evols = @school.evolutions.count
      
      expect{post :create, evolution: @evolution, school_id: @school}.to change(Evolution ,:count).by(1)
      expect(response).to redirect_to school_evolutions_path(@school, @family)
      
      expect(@school.evolutions.count).to eq(qty_evols + 1)
    end
    
    it "should require users to be logged in" do
      post :create, evolution: @evolution, school_id: @school
      expect(response).to redirect_to new_user_session_path
    end
  end
end
