require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CookBook')
    expect(page).to have_css('p', text: 'Bem-vindo ao maior livro de receitas online')
  end

  scenario 'and view recipe' do
    #cria os dados necessários
    user = create(:user)
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          ingredients: 'Cenoura, acucar, oleo e chocolate',
                          method: 'Misturar tudo, bater e assar',
                          cook_time: 60, user: user)

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h2', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view recipes list' do
    #cria os dados necessários
    user = create(:user)
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                           user: user)

    another_recipe_type = RecipeType.create(name: 'Prato Principal')
    another_recipe = create(:recipe, title: 'Feijoada', recipe_type: another_recipe_type,
                          cuisine: cuisine, user: user)


    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h2', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")

    expect(page).to have_css('h2', text: another_recipe.title)
    expect(page).to have_css('li', text: another_recipe.recipe_type.name)
    expect(page).to have_css('li', text: another_recipe.cuisine.name)
    expect(page).to have_css('li', text: another_recipe.difficulty)
    expect(page).to have_css('li', text: "#{another_recipe.cook_time} minutos")
  end

  scenario 'and view just last six recipes' do
    #Setup
    user = create(:user)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe_one = create(:recipe, title: 'Bolo1', recipe_type: recipe_type)
    recipe_two = create(:recipe, title: 'Bolo2', recipe_type: recipe_type)
    recipe_three = create(:recipe, title: 'Bolo3', recipe_type: recipe_type)
    recipe_four = create(:recipe, title: 'Bolo4', recipe_type: recipe_type)
    recipe_five = create(:recipe, title: 'Bolo5', recipe_type: recipe_type)
    recipe_six = create(:recipe, title: 'Bolo6', recipe_type: recipe_type)
    recipe_seven = create(:recipe, title: 'Bolo7', recipe_type: recipe_type)

    #Navigation
    visit root_path

    #Expect
    expect(page).to have_css('h2', text: recipe_two.title)
    expect(page).to have_css('h2', text: recipe_three.title)
    expect(page).to have_css('h2', text: recipe_four.title)
    expect(page).to have_css('h2', text: recipe_five.title)
    expect(page).to have_css('h2', text: recipe_six.title)
    expect(page).to have_css('h2', text: recipe_seven.title)
    expect(page).not_to have_css('h2', text: recipe_one.title)
    expect(page).to have_link('Ver todas receitas')
  end

  scenario 'and view all recipes' do
    #Setup
    user = create(:user)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe_one = create(:recipe, title: 'Bolo1', recipe_type: recipe_type)
    recipe_two = create(:recipe, title: 'Bolo2', recipe_type: recipe_type)
    recipe_three = create(:recipe, title: 'Bolo3', recipe_type: recipe_type)
    recipe_four = create(:recipe, title: 'Bolo4', recipe_type: recipe_type)
    recipe_five = create(:recipe, title: 'Bolo5', recipe_type: recipe_type)
    recipe_six = create(:recipe, title: 'Bolo6', recipe_type: recipe_type)
    recipe_seven = create(:recipe, title: 'Bolo7', recipe_type: recipe_type)

    #Navigation
    visit root_path
    click_on 'Ver todas receitas'
    #Expect
    expect(page).to have_css('h2', text: recipe_two.title)
    expect(page).to have_css('h2', text: recipe_three.title)
    expect(page).to have_css('h2', text: recipe_four.title)
    expect(page).to have_css('h2', text: recipe_five.title)
    expect(page).to have_css('h2', text: recipe_six.title)
    expect(page).to have_css('h2', text: recipe_seven.title)
    expect(page).to have_css('h2', text: recipe_one.title)
    expect(page).to have_link('Voltar')
    expect(page).not_to have_link('Ver todas receitas')

  end
end
