class School < ActiveRecord::Base
  has_many :families
  has_many :children, through: :families
  has_many :bills
  has_many :movements

  has_many :menus
  has_many :foods, through: :menus
end
