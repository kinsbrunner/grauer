class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.integer :family_id
      t.string  :nombre
      t.integer :grado
      t.integer :division
      t.integer :tipo_servicio
      t.text    :comentario

      t.timestamps
    end
    add_index :children, :family_id
  end
end