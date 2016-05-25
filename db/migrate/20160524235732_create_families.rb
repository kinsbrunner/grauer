class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :apellido
      t.string :contacto_1
      t.string :contacto_2
      t.string :tel_cel
      t.string :tel_casa
      t.string :tel_alt
      t.string :email
      t.string :direccion
      t.integer :school_id

      t.timestamps
    end
  end
end
