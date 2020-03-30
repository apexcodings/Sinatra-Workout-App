class User < ActiveRecord::Base
  has_many :workouts
  has_many :equipments, :through => :workouts

  validates :username, presence: true, uniqueness: true, on: :create
  validates :email, presence: true, uniqueness: true , on: :create 
  validates :password_digest, presence: true, on: :create 


  has_secure_password

end