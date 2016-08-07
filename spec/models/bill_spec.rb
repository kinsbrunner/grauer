require 'rails_helper'

RSpec.describe Bill, type: :model do
  # Valid factory test is on factories_spec.rb
  
  it { is_expected.to validate_presence_of(:school_id) }
  it { is_expected.to validate_presence_of(:tipo) }
  it { is_expected.to validate_presence_of(:periodo) }
  it { is_expected.to validate_uniqueness_of(:periodo).scoped_to(:school_id, :tipo).with_message("Ya se ha facturado este período para esta Escuela") }
  it { is_expected.to validate_presence_of(:limite_grp_1) }
  it { is_expected.to validate_presence_of(:valor_1) }
  it { is_expected.to validate_numericality_of(:valor_1) }
  it { is_expected.to have_many(:movements).dependent(:destroy) }
  it { is_expected.to have_many(:menu_day).dependent(:destroy) }
  it { is_expected.to accept_nested_attributes_for(:menu_day) }
  
  context "limite_grp_2 has value" do
    before { allow(subject).to receive(:limite_grp_2).and_return(5) }
    it { is_expected.to validate_presence_of(:valor_2) }
    it { is_expected.to validate_numericality_of(:valor_2) }
  end

  context "limite_grp_3 has value" do
    before { allow(subject).to receive(:limite_grp_3).and_return(10) }
    it { is_expected.to validate_presence_of(:valor_3) }
    it { is_expected.to validate_numericality_of(:valor_3) }
  end

  it { is_expected.to belong_to(:school) }
  it { is_expected.to belong_to(:user) }
end
