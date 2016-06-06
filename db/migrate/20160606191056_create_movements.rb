class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.integer :family_id
      t.integer :user_id
      t.timestamps :fecha
      t.integer :tipo
      t.decimal :monto
      t.decimal :saldo
      t.integer :forma
      t.decimal :descuento, default: 0.00
      t.text :nota
      
      t.timestamps
    end
    add_index :movements, [:user_id, :family_id]
    add_index :movements, :family_id
  end
end
