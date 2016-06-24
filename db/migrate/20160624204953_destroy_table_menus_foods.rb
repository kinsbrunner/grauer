class DestroyTableMenusFoods < ActiveRecord::Migration
  def change
    drop_table :menus_foods
  end
end
