class CuisinesController < ApplicationController

  def new
   @cuisines = Cuisine.new
 end

 def show
   @cuisines = Cuisine.find params[:id]
   @recipes = Recipe.where(cuisine_id: params[:id])
end

  def create
    @cuisine = Cuisine.new(params.require(:cuisine).permit(:name))
    if @cuisine.save
      redirect_to @cuisine
    else
      render '_error_messages'
    end

  end
end

# @recipe_type = RecipeType.new(params.require(:recipe_type).permit(:name))
# if @recipe_type.save
#   redirect_to @recipe_type
