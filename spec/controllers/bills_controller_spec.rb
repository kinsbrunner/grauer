require 'rails_helper'

RSpec.describe BillsController, type: :controller do
    describe "bills#index action" do
      let(:user)   { FactoryGirl.create(:user) }
      let(:school) { FactoryGirl.create(:school) }
      
      it "should require user to be loggged in" do
        get :index, school_id: school
        expect(response).not_to render_template :index
        expect(response).to redirect_to new_user_session_path
      end
      
      it "should return a 404 error message if the school is not found" do
        sign_in user
        get :index, school_id: 'BLABLABLA'
        expect(response).to have_http_status(:not_found)
        expect(response).not_to render_template :index        
      end
      
      it "should show list of daily bills" do
        sign_in user
        get :index, school_id: school, tipo: Bill::TIPOS_FACTURACION['Diaria']
        expect(response).to have_http_status(:success)
        expect(response).to render_template :index
      end
      
      it "should show list of monthly bills" do
        sign_in user
        get :index, school_id: school, tipo: Bill::TIPOS_FACTURACION['Mensual']
        expect(response).to have_http_status(:success)
        expect(response).to render_template :index        
      end
    end
  
    describe "bills#new action" do
      let(:user)        { FactoryGirl.create(:user) }
      let(:school)      { FactoryGirl.create(:school) }
      
      it "should require users to be logged in" do
        get :new, school_id: school, tipo: Bill::TIPOS_FACTURACION['Mensual']
        expect(response).not_to render_template :new
        expect(response).to redirect_to new_user_session_path
      end
      
      it "should return a 404 error message if the school is not found" do
        sign_in user
        get :new, school_id: 'BLABLABLA', tipo: Bill::TIPOS_FACTURACION['Mensual']
        expect(response).to have_http_status(:not_found)
        expect(response).not_to render_template :new
      end
      
      it "should successfully show the new form" do
        sign_in user
        get :new, school_id: school, tipo: Bill::TIPOS_FACTURACION['Mensual']
        expect(response).to have_http_status(:success)
        expect(response).to render_template :new        
      end
    end

    describe "bills#create action" do
      let(:user)        { FactoryGirl.create(:user) }
      let(:school)      { FactoryGirl.create(:school) }
      let(:bill_m)      { FactoryGirl.create(:bill, school_id: school.id, tipo: Bill::TIPOS_FACTURACION['Mensual']) }
      let(:bill_m_inv)  { FactoryGirl.attributes_for(:bill, school_id: school.id, tipo: '') }
      
      it "should require users to be logged in" do
        post :create, school_id: school, tipo: Bill::TIPOS_FACTURACION['Mensual'], bill: bill_m
        expect(response).to redirect_to new_user_session_path        
      end
      
      it "should return a 404 error message if the school is not found" do
        sign_in user
        post :create, school_id: 'BLABLABLA', tipo: Bill::TIPOS_FACTURACION['Mensual'], bill: bill_m
        expect(response).to have_http_status(:not_found)
      end
      
      it "should properly deal with valdation errors" do
        sign_in user
        expect{post :create, school_id: school, tipo: Bill::TIPOS_FACTURACION['Mensual'], bill: bill_m_inv}.not_to change(Bill,:count)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "should successfully create a monthly bill"
      ######################################
      
      it "should successfully create a daily bill"
      ######################################
    end
  
    describe "bills#edit action" do
      let(:user)   { FactoryGirl.create(:user) }
      let(:school) { FactoryGirl.create(:school) }
      let(:bill_m) { FactoryGirl.create(:bill, tipo: Bill::TIPOS_FACTURACION['Mensual'], school_id: school.id) }
      let(:bill_d) { FactoryGirl.create(:bill, tipo: Bill::TIPOS_FACTURACION['Diaria'], school_id: school.id) }
      
      it "should require users to be logged in" do
        get :edit, school_id: school, tipo: Bill::TIPOS_FACTURACION['Mensual'], id: bill_m
        expect(response).not_to render_template :edit
        expect(response).to redirect_to new_user_session_path
      end
      
      it "should return a 404 error message if the school is not found" do
        sign_in user
        get :edit, school_id: 'BLABLABLA', tipo: Bill::TIPOS_FACTURACION['Diaria'], id: bill_d
        expect(response).to have_http_status(:not_found)
        expect(response).not_to render_template :edit
      end
      
      it "should return a 404 error message if the daily bill is not found" do
        sign_in user
        get :edit, school_id: school, tipo: Bill::TIPOS_FACTURACION['Diaria'], id: 'BLABLABLA'
        expect(response).to have_http_status(:not_found)
        expect(response).not_to render_template :edit        
      end
      
      it "should not allow to edit monthly bills" do
        sign_in user
        get :edit, school_id: school, tipo: Bill::TIPOS_FACTURACION['Mensual'], id: bill_m
        expect(response).to have_http_status(:forbidden)
        expect(response).not_to render_template :edit
      end
      
      it "should allow to edit daily bills" do
        sign_in user
        get :edit, school_id: school, tipo: Bill::TIPOS_FACTURACION['Diaria'], id: bill_d
        expect(response).to have_http_status(:success)
        expect(response).to render_template :edit
      end
    end

    describe "bills#update action" do
      let(:user)   { FactoryGirl.create(:user) }
      let(:school) { FactoryGirl.create(:school) }
      let(:bill_m) { FactoryGirl.create(:bill, tipo: Bill::TIPOS_FACTURACION['Mensual'], school_id: school.id) }
      let(:bill_d) { FactoryGirl.create(:bill, tipo: Bill::TIPOS_FACTURACION['Diaria'], school_id: school.id) }
      
      it "should require users to be logged in" do
        patch :update, school_id: school, tipo: Bill::TIPOS_FACTURACION['Diaria'], id: bill_d
        expect(response).to redirect_to new_user_session_path
      end
      
      it "should return a 404 error message if the school is not found" do
        sign_in user
        patch :update, school_id: 'BLABLABLA', tipo: Bill::TIPOS_FACTURACION['Diaria'], id: bill_d
        expect(response).to have_http_status(:not_found)
      end

      it "should return a 404 error message if the bill is not found" do
        sign_in user
        patch :update, school_id: school, tipo: Bill::TIPOS_FACTURACION['Diaria'], id: 'BLABLABLA'
        expect(response).to have_http_status(:not_found)
      end
      
      it "should return a 403 error message if trying to update a monthly bill" do
        sign_in user
        patch :update, school_id: school, tipo: Bill::TIPOS_FACTURACION['Mensual'], id: bill_m
        expect(response).to have_http_status(:forbidden)
      end
      
      it "should successfully update a daily bill"
      ############################################
    end
  
    describe "bills#destroy action" do
      let(:user)       { FactoryGirl.create(:user) }
      let(:school)     { FactoryGirl.create(:school) }
      let!(:bill_m)    { FactoryGirl.create(:bill, tipo: Bill::TIPOS_FACTURACION['Mensual'], school_id: school.id) }
      let(:family_1)   { FactoryGirl.create(:family) }
      let(:children_1) { FactoryGirl.create_list :child, 3, family_id: family_1.id }
      let(:movement_1) { FactoryGirl.create(:movement, bill_id: bill_m.id, family_id: family_1, school_id: school.id, user_id: user.id, tipo: Movement::TIPO_TIPOS['Comedor']) }
      let(:family_2)   { FactoryGirl.create(:family) }
      let(:children_2) { FactoryGirl.create_list :child, 2, family_id: family_2.id }
      let(:movement_2) { FactoryGirl.create(:movement, bill_id: bill_m.id, family_id: family_2, school_id: school.id, user_id: user.id, tipo: Movement::TIPO_TIPOS['Comedor']) }
      
      it "should require users to be logged in" do
        delete :destroy, id: bill_m, school_id: school, tipo: Bill::TIPOS_FACTURACION['Mensual']
        expect(response).to redirect_to new_user_session_path        
      end
      
      it "should return a 404 error message if the school is not found" do
        sign_in user
        delete :destroy, school_id: 'BLABLABLA', tipo: Bill::TIPOS_FACTURACION['Diaria'], id: bill_m
        expect(response).to have_http_status(:not_found)
      end
      
      it "should return a 404 error message if the bill is not found" do
        sign_in user
        delete :destroy, school_id: school, tipo: Bill::TIPOS_FACTURACION['Diaria'], id: 'BLABLABLA'
        expect(response).to have_http_status(:not_found)
      end
      
      it "should successfully delete a monthly bill" do
        sign_in user
        @qty_movs = bill_m.movements.count * -1
        expect{delete :destroy, school_id: school, tipo: Bill::TIPOS_FACTURACION['Mensual'], id: bill_m}.to change(Movement, :count).by(@qty_movs)
        expect(response).to redirect_to school_bills_path(school, tipo: Bill::TIPOS_FACTURACION['Mensual'])
        bm = Bill.find_by_id(bill_m)
        expect(bm).to eq nil
      end
    end
end
