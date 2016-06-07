class AlterFamiliesAddSaldoPrecisionFix < ActiveRecord::Migration
  def change
     change_column :families, :saldo, :decimal, default: 0.00, precision: 10, scale: 2
  end
end
