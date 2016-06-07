class AlterTableMovementsSaldoClear < ActiveRecord::Migration
  def change
    change_column :movements, :saldo, :decimal, default: 0, precision: 8, scale: 2 
  end
end
