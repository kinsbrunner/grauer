class AlterChildrenChangeDivisionType < ActiveRecord::Migration
  def change
    change_column :children, :division, :string
  end
end
