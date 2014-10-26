class AddIndexToCategory < ActiveRecord::Migration
  def change
    add_index :categories, :name, :unique => true
    add_index :subcategories, :name, :unique => true
  end
end
