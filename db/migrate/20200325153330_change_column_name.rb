class ChangeColumnName < ActiveRecord::Migration

  def change
    rename_column :workouts, :exoerience_needed, :experience_needed
  end


end