require 'rails_helper'

RSpec.describe School, type: :model do
  # Valid factory test is on factories_spec.rb

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should have_many(:families) }
  it { should have_many(:children).through(:families)  }  
  it { should have_many(:bills) }
  it { should have_many(:movements) }
  it { should have_many(:evolutions) }
  it { should have_many(:menus) }
  it { should have_many(:foods).through(:menus)  }  
  
  
  it "returns the monthly bill of the current month"
  it "doesn't return the monthly bill of the current month, when it doesnt exist"
  it "returns the daily bill of the current (last) month"
  it "doesn't return the daily bill of the current (last) month, when it doesnt exist"
end
