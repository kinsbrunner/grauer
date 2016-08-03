require 'rails_helper'

RSpec.describe Comment, type: :model do
  # Valid factory test is on factories_spec.rb

  it { should belong_to(:family) }  
  it { should belong_to(:user) }  
end
