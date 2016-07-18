class CreateEvolutions < ActiveRecord::Migration
  def change
    create_table :evolutions do |t|
      t.integer :school_id
      t.integer :user_id
      
      t.timestamps null: false
    end
    add_index :evolutions, :school_id
  end
end
