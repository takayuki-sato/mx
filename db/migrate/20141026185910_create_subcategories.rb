class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.string :name
      t.string :description
      t.string :tag
      t.integer :category_id

      t.timestamps
    end
  end
end
