class AlterMovementAddSchoolId < ActiveRecord::Migration
  def change
    add_column :movements, :school_id, :integer
    add_index :movements, :school_id
  end
end
