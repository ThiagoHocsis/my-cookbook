class RecipesController < ApplicationController

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def create
    recipe_params = params.require(:recipe).permit(:title,
                                                    :recipe_type_id, :cuisine_id, :difficulty,
                                                    :cook_time, :ingredients, :method)

    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      render '_error_messages'
    end
  end

end
