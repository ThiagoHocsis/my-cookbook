class RemoveRecipeTypeIdFromRecipes < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :recipe_tupe, :string
  end
end
