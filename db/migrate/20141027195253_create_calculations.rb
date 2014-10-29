class CreateCalculations < ActiveRecord::Migration
  def change
    create_table :calculations do |t|
      t.belongs_to :area
      t.integer :basic
      t.integer :advanced
      t.integer :professional
      t.integer :other_category
      t.integer :engel
      t.integer :male
      t.integer :femail
      t.integer :enterprise
      t.integer :unknown
      t.integer :consumer
      t.integer :age_0
      t.integer :age_1
      t.integer :age_2
      t.integer :age_3
      t.integer :age_4
      t.integer :age_5
      t.integer :age_6
      t.integer :age_u
      t.integer :young

      t.timestamps
    end
    add_index :calculations, :area_id
  end
end
