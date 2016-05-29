class Family < ActiveRecord::Base
  belongs_to :school
  belongs_to :user

  validates :apellido, presence: true
end
