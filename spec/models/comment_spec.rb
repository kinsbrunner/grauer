require 'rails_helper'

RSpec.describe Comment, type: :model do
  # Valid factory test is on factories_spec.rb

  it { is_expected.to belong_to(:family) }  
  it { is_expected.to belong_to(:user) }  
end
