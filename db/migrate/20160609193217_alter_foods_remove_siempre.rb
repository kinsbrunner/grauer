class AlterFoodsRemoveSiempre < ActiveRecord::Migration
  def change
    remove_column :foods, :siempre
  end
end
