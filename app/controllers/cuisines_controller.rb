class CuisinesController < ApplicationController

  def new
   @cuisines = Cuisine.new
 end

 def show
   @cuisines = Cuisine.find params[:id]
   @recipes = Recipe.where(cuisine_id: params[:id])
end

  def create
    name = params[:cuisine][:name]
    @cuisine = Cuisine.create(name: name)
    @cuisine.save
  end



end
