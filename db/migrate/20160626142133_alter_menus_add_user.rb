class AlterMenusAddUser < ActiveRecord::Migration
  def change
    add_column :menus, :user_id, :integer
    add_index  :menus, :user_id
  end
end
