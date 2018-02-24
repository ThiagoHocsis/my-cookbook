class HomeController < ApplicationController
  def index
    @recipes = Recipe.last(6)
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
    favorites = Favorite.group(:recipe_id).count.sort_by { |_k, v| v }
                        .reverse.to_h
    favorites_array = []
    favorites.each_entry do |k, _v|
      favorites_array << Recipe.find(k)
    end
    @favorites = favorites_array.first(3)
  end
end
