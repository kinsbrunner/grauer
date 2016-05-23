class AlterUsersFieldsOrder < ActiveRecord::Migration
  def change
    change_column :users, :username, :string, after: :id
    change_column :users, :firstname, :string, after: :username
    change_column :users, :lastname, :string, after: :firstname
  end
end
