class AlterMenuDaysRemoveMovement < ActiveRecord::Migration
  def change
    remove_column :menu_days, :movement_id
  end
end
