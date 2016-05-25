class FamiliesAddIndexes < ActiveRecord::Migration
  def change
    add_index :families, :school_id
  end
end
