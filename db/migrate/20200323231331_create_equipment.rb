class CreateEquipment < ActiveRecord::Migration
  
  def change
    create_table :equipments do |t| 
      t.string :name 
      t.string :quantity 
      t.integer :recipe_id
    end

  end
end
