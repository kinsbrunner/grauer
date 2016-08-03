require 'rails_helper'

RSpec.describe School, type: :model do
  # Valid factory test is on factories_spec.rb

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to have_many(:families) }
  it { is_expected.to have_many(:children).through(:families)  }  
  it { is_expected.to have_many(:bills) }
  it { is_expected.to have_many(:movements) }
  it { is_expected.to have_many(:evolutions) }
  it { is_expected.to have_many(:foods).through(:menus)  }  
  it { is_expected.to have_many(:menus) }
  
  
  it "returns the monthly bill of the current month"
  it "doesn't return the monthly bill of the current month, when it doesnt exist"
  it "returns the daily bill of the current (last) month"
  it "doesn't return the daily bill of the current (last) month, when it doesnt exist"
end
