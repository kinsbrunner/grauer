class Menu < ActiveRecord::Base
  belongs_to :school
  belongs_to :user

  
  validates :school_id, presence: true
  validates :fecha, presence: true
end
