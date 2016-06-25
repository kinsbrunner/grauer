class DestroyTableFoodsMenus < ActiveRecord::Migration
  def change
    drop_table :foods_menus
  end
end
