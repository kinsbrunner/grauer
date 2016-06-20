class AlterFamiliesRemoveSaldoField < ActiveRecord::Migration
  def change
    remove_column :families, :saldo
  end
end
