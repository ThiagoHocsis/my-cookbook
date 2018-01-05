class RemoveRecipeTypeFromRecipes < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :recipe_type_id, :string
  end
end
