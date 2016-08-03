require 'rails_helper'

RSpec.describe Family, type: :model do
  # Valid factory test is on factories_spec.rb

  it { is_expected.to validate_presence_of(:apellido) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:school) }
  it { is_expected.to have_many(:children) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:movements) }
end
