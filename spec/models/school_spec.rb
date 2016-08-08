require 'rails_helper'

RSpec.describe School, type: :model do
  # Valid factory test is on factories_spec.rb

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to have_many(:families) }
  it { is_expected.to have_many(:children).through(:families)  }  
  it { is_expected.to have_many(:bills) }
  it { is_expected.to have_many(:movements) }
  it { is_expected.to have_many(:evolutions) }
  it { is_expected.to have_many(:foods).through(:menus)  }  
  it { is_expected.to have_many(:menus) }
  
  before :each do
    @school = FactoryGirl.create(:school)
    curr_month = Date.today.beginning_of_month
    prev_month = Date.today.ago(1.month).beginning_of_month
    prev_2_month = Date.today.ago(2.month).beginning_of_month
    @bill_m1 = FactoryGirl.create(:bill, tipo: Bill::TIPOS_FACTURACION['Mensual'], periodo: prev_month, school: @school)
    @bill_m2 = FactoryGirl.create(:bill, tipo: Bill::TIPOS_FACTURACION['Mensual'], periodo: curr_month, school: @school)
    @bill_d1 = FactoryGirl.create(:bill, tipo: Bill::TIPOS_FACTURACION['Diaria'], periodo: prev_2_month, school: @school)
    @bill_d2 = FactoryGirl.create(:bill, tipo: Bill::TIPOS_FACTURACION['Diaria'], periodo: prev_month, school: @school)
    @bill_d3 = FactoryGirl.create(:bill, tipo: Bill::TIPOS_FACTURACION['Diaria'], periodo: curr_month, school: @school)
  end
  
  it "returns the monthly bill of the current month" do
    expect(@school.ultima_factura_mensual).to eq(@bill_m2)
  end
  
  it "doesn't return the monthly bill of the current month, when it doesnt exist" do
    @bill_m2.destroy
    expect(@school.ultima_factura_mensual).to be_nil
  end

  it "returns the daily bill of the current (last) month" do
    expect(@school.ultima_factura_diaria).to eq(@bill_d2)
  end
  
  it "doesn't return the daily bill of the current (last) month, when it doesnt exist" do
    @bill_d2.destroy
    expect(@school.ultima_factura_diaria).to be_nil    
  end
end
