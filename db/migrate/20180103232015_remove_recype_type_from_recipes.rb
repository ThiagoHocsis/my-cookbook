class RemoveRecypeTypeFromRecipes < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :recipe_type, :string
  end
end
