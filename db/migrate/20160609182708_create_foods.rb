class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.integer :tipo
      t.string :comida
      t.boolean :siempre
      
      t.timestamps
    end
    add_index :foods, :tipo
  end
end
