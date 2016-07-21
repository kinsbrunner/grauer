class MenuDay < ActiveRecord::Base
  belongs_to :bill
  belongs_to :child
  
  
  validates :child_id, presence: true
  validates :cantidad, presence: true
end
