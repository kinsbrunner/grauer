class AlterMovementsAdjustDecimalScales < ActiveRecord::Migration
  def change
    change_column :movements, :monto, :decimal, default: 0.00, precision: 8, scale: 2
    change_column :movements, :descuento, :decimal, default: 0.00, precision: 8, scale: 2
    change_column :movements, :saldo, :decimal, default: 0.00, precision: 8, scale: 2
  end
end
