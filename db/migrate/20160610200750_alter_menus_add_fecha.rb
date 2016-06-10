class AlterMenusAddFecha < ActiveRecord::Migration
  def change
    add_column :menus, :fecha, :datetime
  end
end
