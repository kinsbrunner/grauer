require 'rails_helper'

RSpec.describe Evolution, type: :model do
  # Valid factory test is on factories_spec.rb

  it { is_expected.to validate_presence_of(:school_id) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to belong_to(:school) }
  it { is_expected.to belong_to(:user) }  
end
