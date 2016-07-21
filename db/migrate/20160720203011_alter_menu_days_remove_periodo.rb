class AlterMenuDaysRemovePeriodo < ActiveRecord::Migration
  def change
    remove_column :menu_days, :periodo
  end
end
