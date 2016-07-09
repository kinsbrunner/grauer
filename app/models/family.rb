class Family < ActiveRecord::Base
  belongs_to :school
  belongs_to :user
  has_many   :children
  has_many   :comments
  has_many   :movements

  validates :apellido, presence: true

  def get_saldo
    return self.movements.sum(:monto)
  end
  
  def hijo_menor
    return self.children.order(grado: :ASC, division: :ASC).first
  end
end
