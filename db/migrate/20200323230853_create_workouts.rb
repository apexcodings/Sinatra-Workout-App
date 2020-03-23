class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.string :name
      t.string :description
      t.string :instructions
      t.string :workout_time
      t.string :exoerience_needed
      t.string :equipment_needed
      t.integer :user_id
    end
  end
end