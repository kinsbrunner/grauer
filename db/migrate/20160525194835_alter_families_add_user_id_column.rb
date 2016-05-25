class AlterFamiliesAddUserIdColumn < ActiveRecord::Migration
  def change
    add_column :families, :user_id, :integer
    add_index :families, :user_id
  end
end
