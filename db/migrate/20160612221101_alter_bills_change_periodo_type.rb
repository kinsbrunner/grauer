class AlterBillsChangePeriodoType < ActiveRecord::Migration
  def change
    change_column :bills, :periodo, :string
  end
end
