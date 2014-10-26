class CreateMunicipalities < ActiveRecord::Migration
  def change
    create_table :municipalities do |t|
      t.string :name
      t.string :key

      t.timestamps
    end
    add_index :municipalities, :key, :unique => true
  end
end
