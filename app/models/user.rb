class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :timeoutable

  has_many :families
  has_many :comments
  has_many :movements
  has_many :menus
  has_many :bills
  has_many :evolutions
  
  validates :firstname, presence: true
  validates :lastname, presence: true
  
  attr_accessor :school
  
  after_update :send_password_change_email, if: :needs_password_change_email?
  
  
  private
  
  def needs_password_change_email?
    encrypted_password_changed? && persisted?
  end

  def send_password_change_email
    UserMailer.password_changed(id).deliver
  end
end
