class RecipesController < ApplicationController

  def show
    id = params[:id]
    @recipe = Recipe.find(id)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    title = params[:recipe][:title]
    recipe_type = params[:recipe][:recipe_type]
    cuisine = params[:recipe][:cuisine]
    difficulty = params[:recipe][:difficulty]
    cook_time = params[:recipe][:cook_time]
    ingredients = params[:recipe][:ingredients]
    method = params[:recipe][:method]

    rec = Recipe.new(title: title, recipe_type: recipe_type, cuisine: cuisine,
    difficulty: difficulty, cook_time: cook_time, ingredients: ingredients, method: method)
    rec.save

    redirect_to recipe_path(rec.id)

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
