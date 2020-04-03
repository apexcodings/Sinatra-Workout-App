class Workout < ActiveRecord::Base 

  belongs_to :user 
  has_many :equipments 

  validates :name, presence: true
  validates :description, presence: true
  validates :instructions, presence: true 
  validates :workout_time, presence: true
  validates :experience_needed, presence: true
  validates :equipment_needed, presence: true

end