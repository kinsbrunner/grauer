require 'rails_helper'

RSpec.describe ChildrenController, type: :controller do

  describe "children#new action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @school = FactoryGirl.create(:school)
      @family = FactoryGirl.create(:family)
    end
    
    it "should successfully show the new form" do
      sign_in @user
      get :new, school_id: @school, family_id: @family
      expect(response).to have_http_status(:success)
    end
    
    it "should require users to be logged in" do
      get :new, school_id: @school, family_id: @family
      expect(response).to redirect_to new_user_session_path
    end    
  end

  describe "children#create action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @school = FactoryGirl.create(:school)
      @family = FactoryGirl.create(:family)
      @child = FactoryGirl.attributes_for(:child)
    end

    it "should successfully create a child in our database" do
      sign_in @user
      
      qty_children = @family.children.count
      
      expect{post :create, child: @child, school_id: @school, family_id: @family}.to change(Child ,:count).by(1)
      expect(response).to redirect_to school_family_path(@school, @family)
      
      expect(@family.children.count).to eq(qty_children + 1)
    end
    
    it "should require users to be logged in" do
      post :create, child: @child, school_id: @school, family_id: @family
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "children#edit action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @school = FactoryGirl.create(:school)
      @family = FactoryGirl.create(:family)
      @child = FactoryGirl.create(:child)
    end
    
    it "should successfully show the edit form if the child is found" do
      sign_in @user
      
      get :edit, id: @child, school_id: @school, family_id: @family
      expect(response).to have_http_status(:success)
    end
    
    it "should return a 404 error message if the child is not found" do
      sign_in @user
      
      get :edit, id: 'BLABLABLA', school_id: @school, family_id: @family
      expect(response).to have_http_status(:not_found)
    end
    
    it "should require users to be logged in" do
      get :edit, id: @child, school_id: @school, family_id: @family
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "children#update action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @school = FactoryGirl.create(:school)
      @family = FactoryGirl.create(:family)
      @child = FactoryGirl.create(:child)
    end
    
    it "should allow users to successfully update a child" do
      sign_in @user
      
      patch :update, id: @child, child: FactoryGirl.attributes_for(:child, nombre: "Daniel", tipo_servicio: Child::GRADOS['6to Grado']), school_id: @school, family_id: @family
      expect(response).to redirect_to school_family_path(@school, @family)
      
      @child.reload
      expect(@child.nombre).to eq "Daniel"
      expect(@child.tipo_servicio).to eq Child::GRADOS['6to Grado']
    end

    it "should have HTTP 404 error message if the child cannot be found" do
      sign_in @user
      
      patch :update, id: 'BLABLABLA', child: FactoryGirl.attributes_for(:child, nombre: "Daniel", tipo_servicio: Child::GRADOS['6to Grado']), school_id: @school, family_id: @family
      expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with an http status of unprocessable_entity" do
      sign_in @user
      
      old_name = @child[:nombre]
      patch :update, id: @child, child: FactoryGirl.attributes_for(:child, nombre: ""), school_id: @school, family_id: @family
      expect(response).to have_http_status(:unprocessable_entity)
      
      @child.reload
      expect(@child.nombre).to eq old_name
    end

    it "should require users to be logged in" do
      patch :update, id: @child, child: FactoryGirl.attributes_for(:child, nombre: "Daniel", tipo_servicio: Child::GRADOS['6to Grado']), school_id: @school, family_id: @family
      expect(response).to redirect_to new_user_session_path   
    end
  end

  describe "children#destroy action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @school = FactoryGirl.create(:school)
      @family = FactoryGirl.create(:family)
      @child = FactoryGirl.create(:child)
    end

    it "should successfully delete a child if found" do
      sign_in @user
      
      expect{delete :destroy, id: @child, school_id: @school, family_id: @family}.to change(Child, :count).by(-1)
      expect(response).to redirect_to school_family_path(@school, @family)
      
      ch = Child.find_by_id(@child)
      expect(ch).to eq nil
    end

    it "should return a 404 error message if the child is not found" do
      sign_in @user
      
      expect{delete :destroy, id: 'BLABLABLA', school_id: @school, family_id: @family}.not_to change(Child, :count)
      expect(response).to have_http_status(:not_found)
    end

    it "should require users to be logged in" do
      post :destroy, id: @child, school_id: @school, family_id: @family
      expect(response).to redirect_to new_user_session_path      
    end
  end
end