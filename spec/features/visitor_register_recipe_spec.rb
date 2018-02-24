require 'rails_helper'

feature 'Visitor register recipe' do
  scenario 'successfully' do
    Cuisine.create(name: 'Arabe')
    user = create(:user, email: 'thiago@gmail.com')
    RecipeType.create(name: 'Entrada')
    RecipeType.create(name: 'Prato Principal')
    RecipeType.create(name: 'Sobremesa')

    visit root_path
    click_on 'Enviar uma receita'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Log in'
    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado,
                                   azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir.
                                    Adicione limão a gosto.'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('h3', text: 'Como Preparar')
  end

  scenario 'and must fill in all fields' do
    Cuisine.create(name: 'Arabe')
    user = create(:user, email: 'thiago@gmail.com')

    visit root_path
    click_on 'Enviar uma receita'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Log in'
    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'and register recipe with image' do
    path = 'spec/support/fixtures/bolo_de_cenoura.jpg'
    user = create(:user, email: 'thiago@gmail.com')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de Cenoura',
                             user: user,
                             recipe_type: recipe_type)

    visit root_path
    login_as user
    click_on 'Enviar uma receita'
    fill_in 'Título', with: recipe.title
    select 'Brasileira', from: 'Cozinha'
    select 'Sobremesa', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Farinha, ovo e cenoura'
    fill_in 'Como Preparar', with: 'Misturar tudo e coloque no forno.'
    page.attach_file('Imagem da Receita', Rails.root + path)
    click_on 'Enviar'

    expect(page).to have_css("img[src*='bolo_de_cenoura.jpg']")
  end

  scenario 'and try register recipe with invalid image' do
    path = 'spec/support/fixtures/bolo_de_cenoura.pdf'
    user = create(:user, email: 'thiago@gmail.com')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de Cenoura',
                             user: user,
                             recipe_type: recipe_type)

    visit root_path
    login_as user
    click_on 'Enviar uma receita'
    fill_in 'Título', with: recipe.title
    select 'Brasileira', from: 'Cozinha'
    select 'Sobremesa', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Farinha, ovo e cenoura'
    fill_in 'Como Preparar', with: 'Misturar tudo e coloque no forno.'
    page.attach_file('Imagem da Receita', Rails.root + path)
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end
end
