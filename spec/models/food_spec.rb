require 'rails_helper'

RSpec.describe Food, type: :model do
  # Valid factory test is on factories_spec.rb

  it { should validate_presence_of(:comida) }
  it { should validate_presence_of(:tipo) }
  it { should validate_uniqueness_of(:comida) }
  it { should have_many(:menus) }
  it { should have_many(:schools).through(:menus)  }
end
