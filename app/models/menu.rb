class Menu < ActiveRecord::Base
  belongs_to :user
  belongs_to :school
  belongs_to :food
  
  validates :school_id, presence: true
  validates :fecha, presence: true
  validates :food_id, presence: true, uniqueness: { scope: [:school_id, :fecha] }
end