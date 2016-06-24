class CreateFoodsMenus < ActiveRecord::Migration
  def change
    create_table :foods_menus, :id => false do |t|
      t.integer :food_id
      t.integer :menu_id
    end
    add_index :foods_menus, :menu_id
    add_index :foods_menus, :food_id
  end
end