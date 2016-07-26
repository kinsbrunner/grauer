class MenuDay < ActiveRecord::Base
  belongs_to :bill
  belongs_to :child
  
  validates :child_id, presence: true
  validates :cantidad, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
end
