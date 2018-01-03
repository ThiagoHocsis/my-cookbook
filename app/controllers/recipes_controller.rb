class RecipesController < ApplicationController

  def show
    id = params[:id]
    @recipe = Recipe.find(id)
  end

  def new
    @recipe = Recipe.new
    options_for_select
  end

  def create
    title = params[:recipe][:title]
    recipe_type = params[:recipe][:recipe_type]
    cuisine = params[:recipe][:cuisine]
    difficulty = params[:recipe][:difficulty]
    cook_time = params[:recipe][:cook_time]
    ingredients = params[:recipe][:ingredients]
    method = params[:recipe][:method]
    rec  = Recipe.create(title: title, recipe_type_id: recipe_type, cuisine_id: cuisine,
           difficulty: difficulty, cook_time: cook_time, ingredients: ingredients,
           method: method)
    if rec.save
      @recipe = Recipe.find_by title:title
      redirect_to @recipe
    else
      render '_error_messages'
    end
  end
  def options_for_select
     @cuisine_options_for_select = Cuisine.all.collect {|c| [ c.name, c.id ] }
     @recipe_type_options_for_select = RecipeType.all.collect {|c| [ c.name, c.id ] }
end

end


# t.string "title"
# t.string "recipe_type"
# t.string "cuisine"
# t.string "difficulty"
# t.integer "cook_time"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.string "ingredients"
# t.string "method"
