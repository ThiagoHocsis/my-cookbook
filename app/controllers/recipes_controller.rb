class RecipesController < ApplicationController

  before_action :set_recipe, only: [:show, :edit, :update]
  before_action :set_cuisines, only: [:new, :edit]
  before_action :set_recipe_types, only: [:new, :edit]


#######################################
  #Criar o search com where e like

#######################################

  def show
  end

  def new
    @recipe = Recipe.new

  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      set_cuisines
      set_recipe_types
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render :new

    end
  end


  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      set_cuisines
      set_recipe_types
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render :new
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title,
                                   :recipe_type_id, :cuisine_id, :difficulty,
                                   :cook_time, :ingredients, :method)
  end


  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def set_cuisines
    @cuisines = Cuisine.all
  end

  def set_recipe_types
    @recipe_types = RecipeType.all
  end

end
