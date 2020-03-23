class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :experience_level 
      t.integer :age 
      t.string :height 
      t.string :weight
      t.string :location
    end
  end
end
