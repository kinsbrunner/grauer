require 'rails_helper'

RSpec.describe Food, type: :model do
  # Valid factory test is on factories_spec.rb

  it { is_expected.to validate_presence_of(:comida) }
  it { is_expected.to validate_presence_of(:tipo) }
  it { is_expected.to validate_uniqueness_of(:comida) }
  it { is_expected.to have_many(:menus) }
  it { is_expected.to have_many(:schools).through(:menus)  }
end
