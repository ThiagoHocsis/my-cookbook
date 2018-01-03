class AddRecipeTypeIdToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :recipe_type_id, :integer
  end
end
