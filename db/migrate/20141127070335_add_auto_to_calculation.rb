class AddAutoToCalculation < ActiveRecord::Migration
  def change
    add_column :calculations, :auto, :integer, default: 0
  end
end
