require 'rails_helper'

feature 'visitor searches recipe and' do
  scenario 'successfully' do
    user = create(:user)
    cuisine_br = create(:cuisine)
    cuisine_us = Cuisine.create(name: 'Americana')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    another_recipe_type = RecipeType.create(name: 'Prato Principal')
    recipe_br = Recipe.create(title: 'Bolo de cenoura',
                              recipe_type: recipe_type,
                              cuisine: cuisine_br,
                              difficulty: 'Médio',
                              cook_time: 20,
                              ingredients: 'Farinha, açucar e ovos',
                              method: 'Misture tudo',
                              user: user)
    recipe_us = Recipe.create(title: 'Cheeseburger',
                              recipe_type: another_recipe_type,
                              cuisine: cuisine_us,
                              difficulty: 'Médio',
                              cook_time: 20,
                              ingredients: 'Pão, hamburger, queijo',
                              method: 'Coloque o hamburger',
                              user: user)

    visit root_path
    fill_in 'Busca', with: 'Bolo de cenoura'
    click_on 'Buscar'

    expect(page).to have_css('h1', text: recipe_br.title)
    expect(page).to have_css('li', text: recipe_br.recipe_type.name)
    expect(page).to have_css('li', text: recipe_br.cuisine.name)
    expect(page).to have_css('li', text: recipe_br.difficulty)
    expect(page).to have_css('li', text: "#{recipe_br.cook_time} minutos")

    expect(page).not_to have_content(recipe_us.title)
    expect(page).not_to have_content(recipe_us.recipe_type.name)
    expect(page).not_to have_content(recipe_us.cuisine.name)
  end

  scenario 'and see two recipes' do
    cuisine_one = create(:cuisine)
    cuisine_two = create(:cuisine, name: 'Italiana')
    recipe_type = create(:recipe_type)
    user = create(:user)

    recipe_one = Recipe.create(title: 'Frango assado',
                               recipe_type: recipe_type,
                               cuisine: cuisine_one,
                               difficulty: 'Médio',
                               cook_time: 60,
                               ingredients: 'galo e alho',
                               method: 'Coloque o frango no forno',
                               user: user)
    recipe_two = Recipe.create(title: 'Chicken a parmegiana',
                               recipe_type: recipe_type,
                               cuisine: cuisine_two,
                               difficulty: 'Médio',
                               cook_time: 60,
                               ingredients: 'Frango, mussarela',
                               method: 'Coloque o frango ',
                               user: user)

    recipe_three = Recipe.create(title: 'Bolo de cenoura',
                                 recipe_type: recipe_type,
                                 cuisine: cuisine_one,
                                 difficulty: 'Médio',
                                 cook_time: 60,
                                 ingredients: 'Farinha, açucar, cenoura',
                                 method: 'Cozinhe a cenoura',
                                 user: user)
    visit root_path
    fill_in 'Busca', with: 'Frango'
    click_on 'Buscar'

    expect(page).to have_css('h1', text: recipe_one.title)
    expect(page).to have_css('li', text: recipe_one.recipe_type.name)
    expect(page).to have_css('li', text: recipe_one.cuisine.name)
    expect(page).to have_css('li', text: recipe_one.difficulty)
    expect(page).to have_css('li', text: "#{recipe_one.cook_time} minutos")

    expect(page).to have_css('h1', text: recipe_two.title)
    expect(page).to have_css('li', text: recipe_two.recipe_type.name)
    expect(page).to have_css('li', text: recipe_two.cuisine.name)
    expect(page).to have_css('li', text: recipe_two.difficulty)
    expect(page).to have_css('li', text: "#{recipe_two.cook_time} minutos")

    expect(page).not_to have_content(recipe_three.title)
    expect(page).not_to have_content(recipe_three.recipe_type)
  end

  scenario 'and see nothing' do
    user = create(:user)
    cuisine_one = Cuisine.create(name: 'Brasileira')
    recipe_type = create(:recipe_type)
    recipe_one = Recipe.create(title: 'Frango assado',
                               recipe_type: recipe_type,
                               cuisine: cuisine_one,
                               difficulty: 'Médio',
                               cook_time: 60,
                               ingredients: 'galo e alho',
                               method: 'Coloque o frango no forno',
                               user: user)

    visit root_path
    fill_in 'Busca', with: 'Cenoura'
    click_on 'Buscar'

    expect(page).to have_content('Nenhuma receita encontrada')
    expect(page).not_to have_content(recipe_one.title)
  end
end
