
require 'rails_helper'

feature 'Visitor view recipes by type' do
  scenario 'from home page' do
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = create(:user)
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura e misture',
                           user: user)

    visit root_path
    click_on recipe_type.name

    expect(page).to have_css('h1', text: recipe_type.name)
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view only recipes from same type' do
    user = create(:user)
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')
    dessert_recipe_type = RecipeType.create(name: 'Sobremesa')
    de_recipe = Recipe.create(title: 'Bolo de cenoura',
                              recipe_type: dessert_recipe_type,
                              cuisine: brazilian_cuisine,
                              difficulty: 'Médio',
                              cook_time: 60,
                              ingredients: 'Farinha, açucar, cenoura',
                              method: 'Cozinhe a cenoura e misture',
                              user: user)

    italian_cuisine = Cuisine.create(name: 'Italiana')
    main_recipe_type = RecipeType.create(name: 'Prato Principal')
    main_recipe = Recipe.create(title: 'Macarrão Carbonara',
                                recipe_type: main_recipe_type,
                                cuisine: italian_cuisine,
                                difficulty: 'Difícil',
                                cook_time: 30,
                                ingredients: 'Massa, ovos, bacon',
                                method: 'Frite o bacon; Cozinhe a massa',
                                user: user)

    visit root_path
    click_on main_recipe_type.name

    expect(page).to have_css('h1', text: main_recipe.title)
    expect(page).to have_css('li', text: main_recipe.recipe_type.name)
    expect(page).to have_css('li', text: main_recipe.cuisine.name)
    expect(page).to have_css('li', text: main_recipe.difficulty)
    expect(page).to have_css('li', text: "#{main_recipe.cook_time} minutos")
    expect(page).not_to have_css('h1', text: de_recipe.title)
    expect(page).not_to have_css('li', text: de_recipe.recipe_type.name)
    expect(page).not_to have_css('li', text: de_recipe.cuisine.name)
    expect(page).not_to have_css('li', text: de_recipe.difficulty)
    expect(page).not_to have_css('li', text: "#{de_recipe.cook_time} minutos")
  end

  scenario 'and type has no recipe' do
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura',
                           recipe_type: recipe_type,
                           cuisine: brazilian_cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura')

    main_dish_type = RecipeType.create(name: 'Prato Principal')
    not_found = 'Nenhuma receita encontrada para este tipo de receitas'

    visit root_path
    click_on main_dish_type.name

    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content(not_found)
  end
end
