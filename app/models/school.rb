class School < ActiveRecord::Base
  has_many :families
  has_many :menus
end
