class Evolution < ActiveRecord::Base
  belongs_to :school
  belongs_to :user
  
  validates :school_id, presence: true
  validates :user_id, presence: true
end
