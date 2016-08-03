require 'rails_helper'

RSpec.describe Evolution, type: :model do
  # Valid factory test is on factories_spec.rb

  it { should validate_presence_of(:school_id) }
  it { should validate_presence_of(:user_id) }
  it { should belong_to(:school) }
  it { should belong_to(:user) }  
end
