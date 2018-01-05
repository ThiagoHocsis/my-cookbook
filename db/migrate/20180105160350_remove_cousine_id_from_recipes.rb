class RemoveCousineIdFromRecipes < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :cuisine_id, :string
  end
end
