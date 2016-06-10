class AlterMenusAdjustFields < ActiveRecord::Migration
  def change
    remove_column :menus, :entrada
    remove_column :menus, :plato
    remove_column :menus, :guarnicion
  end
end
