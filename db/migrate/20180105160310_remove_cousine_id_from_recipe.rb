class RemoveCousineIdFromRecipe < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :cousine_id, :string
  end
end
