class AlterFamiliesAddSaldoPrecision < ActiveRecord::Migration
  def change
    change_column :families, :saldo, :decimal, default: 0.00, precision: 2
  end
end
