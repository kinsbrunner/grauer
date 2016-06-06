class AlterTableMovementsAddFecha < ActiveRecord::Migration
  def change
    add_column :movements, :fecha, :datetime, :after => :updated_at
  end
end
