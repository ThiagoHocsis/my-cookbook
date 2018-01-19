require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    user = create(:user)
    arabian_cuisine = Cuisine.create(name: 'Arabe')
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')

    appetizer_type = RecipeType.create(name: 'Entrada')
    main_type = RecipeType.create(name: 'Prato Principal')
    dessert_type = RecipeType.create(name: 'Sobremesa')

    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: main_type,
                          cuisine: arabian_cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos,
                           misture com o restante dos ingredientes', user: user)

    # simula a ação do usuário
    visit root_path
    login_as (user)
    click_on 'Bolodecenoura'
    click_on 'Editar'
    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Brasileira', from: 'Cozinha'
    select 'Sobremesa', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura de chocolate'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Sobremesa')
    expect(page).to have_css('p', text: 'Brasileira')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text:  'Cenoura, farinha, ovo, oleo de soja e chocolate')
    expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura de chocolate')
  end

  scenario 'and all fields must be filled' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    user = create(:user, email:'thiago@gmail.com')
    arabian_cuisine = Cuisine.create(name: 'Arabe')
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')

    appetizer_type = RecipeType.create(name: 'Entrada')
    main_type = RecipeType.create(name: 'Prato Principal')
    dessert_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: main_type,
                          cuisine: arabian_cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos,
                           misture com o restante dos ingredientes', user:user)

    # simula a ação do usuário
    visit root_path
    login_as(user)
    click_on 'Bolodecenoura'
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

    #Setup
    user = create(:user, email: 'thiago@gmail.com')
    another_user = create(:user, email: 'nelson@gmail.com')
    recipe_type = create(:recipe_type, name:'Jantar')
    recipe = create(:recipe, title:'Lasanha', user:user, recipe_type:recipe_type)

    #Navigation
    visit root_path
    login_as(another_user)
    click_on 'Lasanha'

    #Expect
    expect(page).not_to have_link('Editar')
  end

  scenario 'and not is owner of recipe' do

    #Setup
    user = create(:user, email: 'thiago@gmail.com')
    another_user = create(:user, email: 'nelson@gmail.com')
    recipe_type = create(:recipe_type, name:'Jantar')
    recipe = create(:recipe, title:'Lasanha', user:user, recipe_type:recipe_type)

    #Navigation
    visit root_path
    login_as(another_user)
    click_on 'Lasanha'

    #Expect
    expect(page).not_to have_link('Editar')
  end

  scenario 'but is not authenticated' do

    #Setup
    user = create(:user, email: 'thiago@gmail.com')
    another_user = create(:user, email: 'nelson@gmail.com')
    recipe_type = create(:recipe_type, name:'Jantar')
    recipe = create(:recipe, title:'Lasanha', user:user, recipe_type:recipe_type)

    #Navigation
    visit root_path
    click_on 'Lasanha'

    #Expect
    expect(page).not_to have_link('Editar')
  end


end
