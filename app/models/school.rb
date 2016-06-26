class School < ActiveRecord::Base
  has_many :families
  has_many :bills

  has_many :menus
  has_many :foods, through: :menus
end
