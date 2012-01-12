class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email, :on => :create
  has_many :stories
  scope :active, where(:state => "active")
end
