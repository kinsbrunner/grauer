require 'rails_helper'

RSpec.describe Menu, type: :model do
  # Valid factory test is on factories_spec.rb
  
  it { is_expected.to validate_presence_of(:school_id) }
  it { is_expected.to validate_presence_of(:fecha) }
  it { is_expected.to validate_presence_of(:food_id) }
  it { is_expected.to validate_uniqueness_of(:food_id).scoped_to(:school_id, :fecha) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:school) }
  it { is_expected.to belong_to(:food) }
end
