class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable, 
         :timeoutable

  has_many :families, :dependent => :restrict_with_error
  has_many :comments, :dependent => :restrict_with_error
  has_many :movements, :dependent => :restrict_with_error
  has_many :menus, :dependent => :restrict_with_error
  has_many :bills, :dependent => :restrict_with_error
  has_many :evolutions, :dependent => :restrict_with_error
  
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
