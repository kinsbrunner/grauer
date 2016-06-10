class Menu < ActiveRecord::Base
  belongs_to :school
  belongs_to :user
  has_and_belongs_to_many :foods
  
  validates :school_id, presence: true
  validates :fecha, presence: true
  validates :entrada, presence: true
  validates :plato, presence: true
  validates :guarnicion, presence: true
end
