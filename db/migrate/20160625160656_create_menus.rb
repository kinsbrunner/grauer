class CreateMenus < ActiveRecord::Migration
  def change
    drop_table :menus

    create_table :menus do |t|
      t.belongs_to :school, index: true
      t.belongs_to :food, index: true
      t.date    :fecha
      t.integer :orden

      t.timestamps
    end
    add_index :menus, :fecha
    add_index :menus, [:school_id, :fecha]
  end
end
