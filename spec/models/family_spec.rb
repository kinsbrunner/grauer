require 'rails_helper'

RSpec.describe Family, type: :model do
  # Valid factory test is on factories_spec.rb

  it { should validate_presence_of(:apellido) }
  it { should belong_to(:user) }
  it { should belong_to(:school) }
  it { should have_many(:children) }
  it { should have_many(:comments) }
  it { should have_many(:movements) }
end
