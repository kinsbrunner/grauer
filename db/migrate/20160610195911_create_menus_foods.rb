class CreateMenusFoods < ActiveRecord::Migration
  def change
    create_table :menus_foods, :id => false do |t|
      t.integer :menu_id
      t.integer :food_id
    end
    add_index :menus_foods, :menu_id
  end
end
