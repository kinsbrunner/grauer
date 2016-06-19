class AlterMovementsAddBillId < ActiveRecord::Migration
  def change
    add_column :movements, :bill_id, :integer
    
    add_index :movements, :bill_id
  end
end
