class AlterFoodsChangeFieldname < ActiveRecord::Migration
  def change
    rename_column :foods, :nota, :comida
  end
end
