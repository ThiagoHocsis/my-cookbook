require 'rails_helper'

feature 'user favorite recipe' do
  scenario 'successfully' do
    user = create(:user, email: 'thiago@gmail.com')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de banana',
                             user: user,
                             recipe_type: recipe_type)

    login_as user
    visit root_path
    click_on recipe.title
    click_on 'Adicionar receita como favorita'

    expect(page).to have_content('Receita adicionada como favorita')
    expect(page).not_to have_link('Adicionar receita como favorita')
    expect(page).to have_link('Remover receita como favorita')
  end

  scenario 'and unfavorite' do
    user = create(:user, email: 'thiago@gmail.com')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de banana',
                             user: user,
                             recipe_type: recipe_type)

    login_as user
    visit root_path
    click_on recipe.title
    click_on 'Adicionar receita como favorita'
    click_on 'Remover receita como favorita'

    expect(page).to have_content('Receita removida como favorita')
    expect(page).to have_link('Adicionar receita como favorita')
    expect(page).not_to have_link('Remover receita como favorita')
  end

  scenario 'and see most favorited recipes' do
    user = create(:user)
    user_two = create(:user, email: 'user_two@gmail.com')
    user_three = create(:user, email: 'user_three@gmail.com')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de banana',
                             user: user,
                             recipe_type: recipe_type)
    recipe_two = create(:recipe, title: 'Bolo de Cenoura',
                                 user: user,
                                 recipe_type: recipe_type)

    login_as user
    visit root_path
    click_on recipe.title, match: :first
    click_on 'Adicionar receita como favorita'
    click_on 'Sair'
    login_as user_two
    visit root_path
    click_on recipe.title, match: :first
    click_on 'Adicionar receita como favorita'
    click_on 'Sair'
    login_as user_three
    visit root_path
    click_on recipe_two.title, match: :first
    click_on 'Adicionar receita como favorita'
    click_on 'Sair'

    expect(page).to have_content(recipe.title)
  end
end
