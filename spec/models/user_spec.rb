require 'rails_helper'

RSpec.describe User, type: :model do
  # Valid factory test is on factories_spec.rb
  
  it { is_expected.to validate_presence_of(:firstname) }
  it { is_expected.to validate_presence_of(:lastname) }
  it { is_expected.to have_many(:families) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:movements) }  
  it { is_expected.to have_many(:menus) }  
  it { is_expected.to have_many(:bills) }  
  it { is_expected.to have_many(:evolutions) }  
end
