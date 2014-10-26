class AddValidToArea < ActiveRecord::Migration
  def change
    add_column :areas, :available, :boolean, :null => false, :default => false
  end
end
