require 'rails_helper'

RSpec.describe Movement, type: :model do
  # Valid factory test is on factories_spec.rb

  it { is_expected.to validate_presence_of(:tipo) }
  it { is_expected.to validate_presence_of(:monto) }
  it { is_expected.to validate_numericality_of(:monto) }
  it { is_expected.to validate_presence_of(:descuento) }
  it { is_expected.to belong_to(:family) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:bill) }
  it { is_expected.to belong_to(:school) }
  
  context "payments" do
    it { is_expected.to validate_presence_of(:forma) }

    it "should adjust Monto when Payment has Descuento" do
      @mov = FactoryGirl.build(:movement, tipo: Movement::TIPO_TIPOS['Pago'], descuento: 0.10)
      @new_val = -@mov.monto * (1 - @mov.descuento)
      expect{@mov.save}.to change{@mov.monto}.to(@new_val)
      #Acá deberia agregar un DESCUENTO
    end

    it "should not adjust Monto when Payment has no Descuento" do
      @mov = FactoryGirl.build(:movement, tipo: Movement::TIPO_TIPOS['Pago'], descuento: 0)
      expect{@mov.save}.to change{@mov.monto}.to(-@mov.monto)
    end     
  end
  
  context "deductions" do    
    it "should not adjust Monto" do
      @mov = FactoryGirl.build(:movement, tipo: Movement::TIPO_TIPOS['Comedor'])
      expect{@mov.save}.not_to change{@mov.monto}
    end        
  end
end
