class ChangeDataTypeForCuisine < ActiveRecord::Migration[5.1]
  def change
    change_column :recipes, :cuisine, :string
  end
end
