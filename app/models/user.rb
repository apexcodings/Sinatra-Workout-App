class User < ActiveRecord::Base
  has_many :workouts
  has_many :equipments, :through => :workouts

  has_secure_password

end