require 'rails_helper'

RSpec.describe MenuDay, type: :model do
  # Valid factory test is on factories_spec.rb

  it { is_expected.to validate_presence_of(:child_id) }
  it { is_expected.to validate_presence_of(:cantidad) }
  it { is_expected.to validate_numericality_of(:cantidad).is_greater_than_or_equal_to(0) }
  it { is_expected.to belong_to(:bill) }
  it { is_expected.to belong_to(:child) }  
end
