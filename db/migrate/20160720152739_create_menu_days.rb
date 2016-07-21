class CreateMenuDays < ActiveRecord::Migration
  def change
    create_table :menu_days do |t|
      t.integer :bill_id
      t.integer :movement_id
      t.integer :child_id
      t.date    :periodo
      t.integer :cantidad
      
      t.timestamps null: false
    end
    add_index :menu_days, :bill_id
    add_index :menu_days, :child_id
  end
end
