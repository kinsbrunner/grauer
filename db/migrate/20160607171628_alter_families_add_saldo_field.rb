class AlterFamiliesAddSaldoField < ActiveRecord::Migration
  def change
    add_column :families, :saldo, :decimal, default: 0.00
  end
end
