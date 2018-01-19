class RecipesController < ApplicationController
  before_action :authenticate_user!, only:[:new, :edit, :update]
  before_action :set_recipe, only: [:show, :edit, :update, :favorite, :unfavorite, :destroy]
  before_action :set_cuisines, only: [:new, :edit, :update]
  before_action :set_recipe_types, only: [:new, :edit, :update]
  before_action :owner, only:[:edit]

  def show
  end

  def destroy
    @recipe.destroy
    redirect_to root_path
    flash[:notice] = "Receita removida com sucesso"
  end

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe
    else
      set_cuisines
      set_recipe_types
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render :new

    end
  end

  def favorite
    @favorite = Favorite.create(user:current_user, recipe: @recipe)
    redirect_to @recipe
    flash[:notice] = "Receita adicionada como favorita"
  end

  def unfavorite
    @favorite = Favorite.find_by(user:current_user, recipe: @recipe)
    @favorite.destroy
    redirect_to @recipe
    flash[:notice] = "Receita removida como favorita"
  end

  def search
    @search = params[:q]
    @recipes = Recipe.where("title LIKE ? OR ingredients LIKE ?","%#{@search}%", "%#{@search}%")
  end


  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render :edit
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title,
                                   :recipe_type_id, :cuisine_id, :difficulty,
                                   :cook_time, :ingredients, :method, :user_id)
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

  def owner
   @recipe = Recipe.find(params[:id])
   unless current_user.is_owner?(@recipe)
     redirect_to root_path
   end
 end

end
