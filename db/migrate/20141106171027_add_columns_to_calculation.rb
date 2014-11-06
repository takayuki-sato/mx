class AddColumnsToCalculation < ActiveRecord::Migration
  def change
    add_column :calculations, :formatted_address, :string
    add_column :calculations, :latitude, :float
    add_column :calculations, :longitude, :float
    add_column :calculations, :northeast_lat, :float
    add_column :calculations, :northeast_lng, :float
    add_column :calculations, :southwest_lat, :float
    add_column :calculations, :southwest_lng, :float
  end
end
