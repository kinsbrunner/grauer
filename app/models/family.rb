class Family < ActiveRecord::Base
  belongs_to :school
  belongs_to :user
  has_many   :children
  has_many   :comments

  validates :apellido, presence: true
end
