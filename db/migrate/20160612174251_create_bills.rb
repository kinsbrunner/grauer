class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :school_id
      t.integer :user_id
      t.integer :tipo
      t.date    :periodo
      t.integer :limite_grp_1
      t.decimal :valor_1
      t.integer :limite_grp_2
      t.decimal :valor_2
      t.integer :limite_grp_3
      t.decimal :valor_3
      
      t.timestamps
    end
    add_index :bills, [:user_id, :school_id]
    add_index :bills, :school_id
  end
end
