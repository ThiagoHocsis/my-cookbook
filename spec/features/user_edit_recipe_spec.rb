require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    user = create(:user)
    arabian_cuisine = Cuisine.create(name: 'Arabe')
    br = Cuisine.create(name: 'Brasileira')
    sobremesa = RecipeType.create(name: 'Sobremesa')
    main_type = RecipeType.create(name: 'Prato Principal')
    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: main_type,
                           cuisine: arabian_cuisine, difficulty: 'Médio',
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura,
                           corte em pedaços pequenos,
                           misture com o restante dos ingredientes',
                           user: user)

    visit root_path
    login_as user
    click_on recipe.title
    click_on 'Editar'
    fill_in 'Título', with: 'Bolo de cenoura'
    select br.name, from: 'Cozinha'
    select sobremesa.name, from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo e chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Sobremesa')
    expect(page).to have_css('p', text: 'Brasileira')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text: 'Cenoura, farinha, ovo e chocolate')
    expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura')
  end

  scenario 'and all fields must be filled' do
    user = create(:user)
    arabian_cuisine = Cuisine.create(name: 'Arabe')
    main_type = RecipeType.create(name: 'Prato Principal')
    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: main_type,
                           cuisine: arabian_cuisine, difficulty: 'Médio',
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura,
                           corte em pedaços pequenos,
                           misture com o restante dos ingredientes',
                           user: user)

    visit root_path
    login_as user
    click_on recipe.title
    click_on 'Editar'
    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'and not is owner of recipe' do
    user = create(:user, email: 'thiago@gmail.com')
    another_user = create(:user, email: 'nelson@gmail.com')
    recipe_type = create(:recipe_type, name: 'Jantar')
    recipe = create(:recipe, title: 'Lasanha',
                             user: user,
                             recipe_type: recipe_type)

    visit root_path
    login_as another_user
    click_on recipe.title

    expect(page).not_to have_link('Editar')
  end

  scenario 'and not is owner of recipe' do
    user = create(:user, email: 'thiago@gmail.com')
    another_user = create(:user, email: 'nelson@gmail.com')
    recipe_type = create(:recipe_type, name: 'Jantar')
    recipe = create(:recipe, title: 'Lasanha',
                             user: user,
                             recipe_type: recipe_type)

    visit root_path
    login_as another_user
    click_on recipe.title

    expect(page).not_to have_link('Editar')
  end

  scenario 'but is not authenticated' do
    user = create(:user, email: 'thiago@gmail.com')
    recipe_type = create(:recipe_type, name: 'Jantar')
    recipe = create(:recipe, title: 'Lasanha',
                             user: user,
                             recipe_type: recipe_type)

    visit root_path
    click_on recipe.title

    expect(page).not_to have_link('Editar')
  end
end
