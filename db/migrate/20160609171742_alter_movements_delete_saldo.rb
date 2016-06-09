class AlterMovementsDeleteSaldo < ActiveRecord::Migration
  def change
    remove_column :movements, :saldo
  end
end
