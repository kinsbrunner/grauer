class Child < ActiveRecord::Base
  belongs_to :family

  validates :nombre, presence: true
  validates :grado, presence: true
  validates :division, presence: true
  validates :tipo_servicio, presence: true
end
