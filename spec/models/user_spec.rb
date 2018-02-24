require 'rails_helper'

RSpec.describe User, type: :model do
  context 'check if the recipe is favorite' do
    it 'successfully' do
      user = create(:user, email: 'thiago@gmail.com')
      recipe_type = create(:recipe_type, name: 'Sobremesa')
      recipe = create(:recipe, recipe_type: recipe_type,
                               user: user)
      Favorite.create(user: user, recipe: recipe)

      favorite = user.favorite?(recipe)

      expect(favorite).to be_truthy
    end
  end

  context 'check if you own the recipe' do
    it 'successfully' do
      user = User.create(email: 'thiago@gmail.com')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      recipe = Recipe.create(recipe_type: recipe_type,
                             user: user)

      owner = user.owner?(recipe)

      expect(owner).to be_truthy
    end
  end
end
