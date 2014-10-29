class ChangeColumnsToCalculation < ActiveRecord::Migration
  def up
    change_column :calculations, :basic, :integer, default: 0
    change_column :calculations, :advanced, :integer, default: 0
    change_column :calculations, :professional, :integer, default: 0
    change_column :calculations, :other_category, :integer, default: 0
    change_column :calculations, :engel, :float, default: 0
    change_column :calculations, :male, :integer, default: 0
    #change_column :calculations, :femail, :integer, default: 0
    change_column :calculations, :enterprise, :integer, default: 0
    change_column :calculations, :unknown, :integer, default: 0
    change_column :calculations, :consumer, :float, default: 0
    change_column :calculations, :age_0, :integer, default: 0
    change_column :calculations, :age_1, :integer, default: 0
    change_column :calculations, :age_2, :integer, default: 0
    change_column :calculations, :age_3, :integer, default: 0
    change_column :calculations, :age_4, :integer, default: 0
    change_column :calculations, :age_5, :integer, default: 0
    change_column :calculations, :age_6, :integer, default: 0
    change_column :calculations, :age_u, :integer, default: 0
    change_column :calculations, :young, :float, default: 0

    remove_column :calculations, :femail
    add_column :calculations, :female, :integer, default: 0

    remove_index :calculations, :area_id
    add_index :calculations, :area_id, unique: true
  end
  def down
    change_column :calculations, :basic, :integer
    change_column :calculations, :advanced, :integer
    change_column :calculations, :professional, :integer
    change_column :calculations, :other_category, :integer
    change_column :calculations, :engel, :integer
    change_column :calculations, :male, :integer
    #change_column :calculations, :femail, :integer
    change_column :calculations, :enterprise, :integer
    change_column :calculations, :unknown, :integer
    change_column :calculations, :consumer, :integer
    change_column :calculations, :age_0, :integer
    change_column :calculations, :age_1, :integer
    change_column :calculations, :age_2, :integer
    change_column :calculations, :age_3, :integer
    change_column :calculations, :age_4, :integer
    change_column :calculations, :age_5, :integer
    change_column :calculations, :age_6, :integer
    change_column :calculations, :age_u, :integer
    change_column :calculations, :young, :integer

    remove_column :calculations, :female
    add_column :calculations, :femail, :integer

    remove_index :calculations, :area_id
    add_index :calculations, :area_id
  end
end
