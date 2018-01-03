class RecipeTypesController < ApplicationController

  def show
    id = params[:id]
    @recipe_type = RecipeType.find(id)
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    name = params[:recipe_type][:name]
    rec_type = RecipeType.create(name: name)
    rec_type.save
    redirect_to recipe_type_path(rec_type.id)

  end
end
