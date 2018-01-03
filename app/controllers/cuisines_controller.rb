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
    cui = Cuisine.create(name: name)
    if cui.save
      redirect_to cuisine_path(cui.id)
    else
        render '_error_messages'
    end

  end



end
