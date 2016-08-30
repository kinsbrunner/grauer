require 'rails_helper'
require 'pp'

RSpec.describe MenusController, type: :controller do
  describe "menus#index action" do
    let(:user)   { FactoryGirl.create(:user) }
    let(:school) { FactoryGirl.create(:school) }    
    let(:foods)  { FactoryGirl.create_list :food, 4 }
    
    it "should successfully show the page" do
      sign_in user
      
      get :index, school_id: school
      expect(assigns(:foods_p)).to match_array foods
      expect(response).to have_http_status(:success)
      expect(response).to render_template :index
    end

    it "should return a 404 error message if the school is not found" do
      sign_in user
      
      get :index, school_id: 'BLABLABLA'
      expect(response).to have_http_status(:not_found)
      expect(response).not_to render_template :index
    end
    
    it "should require users to be logged in" do
      get :index, school_id: school
      expect(response).not_to render_template :index
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "menus#create action" do
    let(:user)   { FactoryGirl.create(:user) }
    let(:school) { FactoryGirl.create(:school) }
    let(:food)   { FactoryGirl.create(:food) }
    let(:menu_attrs) { FactoryGirl.attributes_for(:menu, food_id: food.id, school_id: school.id, user_id: user.id) }
    
    it "should successfully create a menu in our database" do
      sign_in user
      
      expect{post :create, menu: menu_attrs, school_id: school}.to change(Menu,:count).by(1)
      
      new_menu = Menu.last
      expect(new_menu.fecha).to eq(menu_attrs[:fecha])
      expect(new_menu.food_id).to eq(menu_attrs[:food_id])
      
      @expected = { :menuId  => new_menu.id }.to_json
      expect(response.body).to eq(@expected)
    end

    it "should require users to be logged in" do
      post :create, menu: menu_attrs, school_id: school
      expect(response).to redirect_to new_user_session_path
    end
  end

    describe "menus#update action" do
      let(:user)   { FactoryGirl.create(:user) }
      let(:school) { FactoryGirl.create(:school) }
      let(:food)   { FactoryGirl.create(:food) }
      let!(:menu)   { FactoryGirl.create(:menu, food_id: food.id, school_id: school.id, user_id: user.id, fecha: Date.today) }

    it "should allow users to successfully update a menu" do
      sign_in user
      
      #@expected = { :status  => 0 }.to_json
      patch :update, id: menu, menu: FactoryGirl.attributes_for(:menu), school_id: school, fecha: Date.yesterday
      #expect(response.body).to eq(@expected)
      menu.reload
      expect(menu.fecha).to eq(Date.yesterday)
    end

    it "should not update a menu when moving it into the same date" do
      sign_in user
      
      @expected = { :status  => -1 }.to_json
      patch :update, id: menu, menu: FactoryGirl.attributes_for(:menu), school_id: school, fecha: Date.today
      expect(response.body).to eq(@expected)
    end

    it "should have HTTP 404 error message if the food cannot be found" do
      sign_in user
      
      patch :update, id: 'BLABLABLA', menu: FactoryGirl.attributes_for(:menu, fecha: Date.yesterday), school_id: school
      expect(response).to have_http_status(:not_found)
    end
    
    it "should require users to be logged in" do
      patch :update, id: menu, menu: FactoryGirl.attributes_for(:menu, fecha: Date.yesterday), school_id: school
      expect(response).to redirect_to new_user_session_path   
    end
  end

  describe "menus#destroy action" do
    let(:user)   { FactoryGirl.create(:user) }
    let(:school) { FactoryGirl.create(:school) }
    let(:food)   { FactoryGirl.create(:food) }
    let!(:menu)  { FactoryGirl.create(:menu, food_id: food.id, school_id: school.id, user_id: user.id) }          

    it "should successfully delete a menu if found" do
      sign_in user
      
      @expected = { :status  => 0 }.to_json
      expect{delete :destroy, id: menu, school_id: school}.to change(Menu,:count).by(-1)
      expect(response.body).to eq(@expected)
      
      m = Menu.find_by_id(menu)
      expect(m).to eq nil
    end

    it "should return a 404 error message if the child is not found" do
      sign_in user

      @expected = { :status  => -1 }.to_json
      expect{delete :destroy, id: 'BLABLABLA', school_id: school}.not_to change(Menu, :count)
      expect(response.body).to eq(@expected)    
    end

    it "should require users to be logged in" do
      delete :destroy, id: menu, school_id: school
      expect(response).to redirect_to new_user_session_path
    end
  end
end