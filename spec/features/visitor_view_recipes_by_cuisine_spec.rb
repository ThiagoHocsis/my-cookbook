require 'rails_helper'

feature 'Visitor view recipes by cuisine' do
  scenario 'from home page' do
    user = create(:user)
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura',
                           recipe_type: recipe_type,
                           cuisine: cuisine,
                           difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura',
                           user: user)

    visit root_path
    click_on cuisine.name

    expect(page).to have_css('h1', text: cuisine.name)
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view only cuisine recipes' do
    user = create(:user)
    ita_cuisine = Cuisine.create(name: 'Italiana')
    main_recipe_type = RecipeType.create(name: 'Prato Principal')
    ita_recipe = Recipe.create(title: 'Macarrão Carbonara',
                               recipe_type: main_recipe_type,
                               cuisine: ita_cuisine,
                               difficulty: 'Difícil',
                               cook_time: 30,
                               ingredients: 'Massa, ovos, bacon',
                               method: 'Frite o bacon',
                               user: user)

    visit root_path
    click_on ita_cuisine.name

    expect(page).to have_css('h1', text: ita_recipe.title)
    expect(page).to have_css('li', text: ita_recipe.recipe_type.name)
    expect(page).to have_css('li', text: ita_recipe.cuisine.name)
    expect(page).to have_css('li', text: ita_recipe.difficulty)
    expect(page).to have_css('li', text: "#{ita_recipe.cook_time} minutos")
  end

  scenario 'and cuisine has no recipe' do
    not_found = 'Nenhuma receita encontrada para este tipo de cozinha'
    user = create(:user)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura',
                           recipe_type: recipe_type,
                           cuisine: brazilian_cuisine,
                           difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura',
                           user: user)

    italian_cuisine = Cuisine.create(name: 'Italiana')

    visit root_path
    click_on italian_cuisine.name

    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content(not_found)
  end
end
