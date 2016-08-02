require 'rails_helper'

RSpec.describe Food, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:food)).to be_valid
  end
  
  it "is invalid without a Comida" do
    f = FactoryGirl.build(:food, comida: nil)
    expect(f).not_to be_valid
  end
  
  it "is invalid without a Tipo de Comida" do
    f = FactoryGirl.build(:food, tipo: nil)
    expect(f).not_to be_valid
  end
  
  it "is not possible to have same value for Comida on different objects" do
    f1 = FactoryGirl.create(:food, comida: 'Asado')
    f2 = FactoryGirl.build(:food, comida: 'Asado')
    expect(f2).not_to be_valid
  end
end
