class Menu < ActiveRecord::Base
  belongs_to :school
  belongs_to :user
  has_and_belongs_to_many :foods
  
  validates :school_id, presence: true
  validates :fecha, presence: true
  validates :food_id, presence: true
end
