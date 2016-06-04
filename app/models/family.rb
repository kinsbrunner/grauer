class Family < ActiveRecord::Base
  belongs_to :school
  belongs_to :user
  has_many   :children

  validates :apellido, presence: true
end
