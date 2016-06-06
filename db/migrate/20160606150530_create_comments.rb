class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :message
      t.integer :family_id
      t.integer :user_id
      
      t.timestamps
    end
    
    add_index :comments, [:user_id, :family_id]
    add_index :comments, :family_id
  end
end
