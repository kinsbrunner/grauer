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
  end
  
  context "deductions" do
    
  end
  
  
  # add_descuento
  # adjust_monto
end
