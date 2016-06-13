class AlterBillsChangePeriodType2 < ActiveRecord::Migration
  def change
    remove_column :bills, :periodo
    add_column :bills, :periodo, :date
  end
end
