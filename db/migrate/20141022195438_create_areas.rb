class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :zipcode
      t.string :city
      t.string :town

      t.timestamps
    end
    add_index :areas, :zipcode, :unique => true
  end
end
