require 'rails_helper'

RSpec.describe MovementsController, type: :controller do
  describe "movements#new action" do
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

  describe "movements#create action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @school = FactoryGirl.create(:school)
      @family = FactoryGirl.create(:family)
      @movement = FactoryGirl.attributes_for(:movement)
    end

    it "should successfully create a movement in our database" do
      sign_in @user
      
      qty_movs = @family.movements.count
      saldo_previo = @family.get_saldo
      
      expect{post :create, movement: @movement, school_id: @school, family_id: @family}.to change(Movement ,:count).by(1)
      expect(response).to redirect_to school_family_path(@school, @family)
      
      expect(@family.movements.count).to eq(qty_movs + 1)      
      expect(@family.get_saldo).not_to eq(saldo_previo)
    end
    
    it "should generate an additional Movement when entering a Payment with discount" do
      sign_in @user
      
      @movement[:tipo] = Movement::TIPO_TIPOS['Pago']
      @movement[:descuento] = Movement::TIPO_DESCUENTOS['15 %']
      
      qty_movs = @family.movements.count
      
      expect{post :create, movement: @movement, school_id: @school, family_id: @family}.to change(Movement ,:count).by(2)
      expect(response).to redirect_to school_family_path(@school, @family)
      
      new_mov = Movement.last
      expect(@family.movements.count).to eq(qty_movs + 2)
      expect(new_mov.tipo).to eq(Movement::TIPO_TIPOS['Descuento'])
    end
    
    it "should require users to be logged in" do
      post :create, movement: @movement, school_id: @school, family_id: @family
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "movements#destroy action" do
    before :each do
      @user = FactoryGirl.create(:user)
      @school = FactoryGirl.create(:school)
      @family = FactoryGirl.create(:family)
      @movement = FactoryGirl.create(:movement)
    end

    it "should successfully delete a movement if found" do
      sign_in @user
      
      expect{delete :destroy, id: @movement, school_id: @school, family_id: @family}.to change(Movement, :count).by(-1)
      expect(response).to redirect_to school_family_path(@school, @family)
      
      m = Movement.find_by_id(@movement)
      expect(m).to eq nil
    end

    it "should return a 404 error message if the food is not found" do
      sign_in @user
      
      expect{delete :destroy, id: 'BLABLABLA', school_id: @school, family_id: @family}.not_to change(Movement, :count)
      expect(response).to have_http_status(:not_found)
    end

    it "should require users to be logged in" do
      post :destroy, id: @movement, school_id: @school, family_id: @family
      expect(response).to redirect_to new_user_session_path      
    end
  end
end
