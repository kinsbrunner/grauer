class Family < ActiveRecord::Base
  belongs_to :school

  validates :apellido, presence: true
end
