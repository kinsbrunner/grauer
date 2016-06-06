class Movement < ActiveRecord::Base
  belongs_to :family
  belongs_to :user
  
  validates :fecha, presence: true
  validates :tipo, presence: true
  validates :monto, presence: true
  validates :descuento, presence: true
end
