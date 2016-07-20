class AlterFamiliesAddActivo < ActiveRecord::Migration
  def change
    add_column :families, :activo, :boolean, :default => 'true'
    Family.all.each do |f|
      f.update_attributes!(:activo => 'true')
    end    
  end
end
