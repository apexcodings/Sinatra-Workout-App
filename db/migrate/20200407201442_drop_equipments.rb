class DropEquipments < ActiveRecord::Migration
  def change
    drop_table :equipments
  end
end
