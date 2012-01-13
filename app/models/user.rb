class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  validates_uniqueness_of :email, :on => :create
  has_many :stories
  has_many :comments
  
  scope :active, where(:state => "active")
  
  state_machine :state, :initial => :active do
    
  end
  
end
