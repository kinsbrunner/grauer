class AlterTableMovementsChangeFechaPosition < ActiveRecord::Migration
  def up
    change_column :movements, :fecha, :datetime, after: :updated_at
  end
end
