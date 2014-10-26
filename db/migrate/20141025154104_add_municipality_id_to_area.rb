class AddMunicipalityIdToArea < ActiveRecord::Migration
  def change
    add_column :areas, :municipality_id, :integer
    add_index :areas, :municipality_id
  end
end
