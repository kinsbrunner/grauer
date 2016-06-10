class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.integer :school_id
      t.integer :user_id
      t.timestamps :fecha
      t.integer :entrada
      t.integer :plato
      t.integer :guarnicion
      
      t.timestamps
    end
    add_index :menus, [:user_id, :school_id]
    add_index :menus, :school_id
  end
end
