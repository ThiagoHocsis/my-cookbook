require 'rails_helper'

RSpec.describe User, type: :model do
  context "check if the recipe is favorite" do
    it "successfully" do
    #Setup
    user = create(:user, email:'thiago@gmail.com')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, recipe_type: recipe_type, user: user)
    Favorite.create(user: user, recipe: recipe)

    ###Test method
    favorite = user.favorite?(recipe)

    #Expect
    expect(favorite).to be_truthy
    end
  end

  context "check if you own the recipe" do
    it "successfully" do
    #Setup
    user = create(:user, email:'thiago@gmail.com')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, recipe_type: recipe_type, user: user)

    ###Test method
    owner = user.is_owner?(recipe)

    #Expect
    expect(owner).to be_truthy
    end
  end
end
