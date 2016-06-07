class AlterTableMovementsRemoveFecha < ActiveRecord::Migration
  def change
    remove_column :movements, :fecha
  end
end
