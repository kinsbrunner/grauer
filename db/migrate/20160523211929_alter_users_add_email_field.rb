class AlterUsersAddEmailField < ActiveRecord::Migration
  def change
    add_column :users, :email, :string, default: "", null: false
    add_index :users, :email,                unique: true
  end
end
