require 'rails_helper'

feature 'user try to delete recipe' do
  scenario 'successfully' do

    #setup
    user = create(:user)
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de Cenoura', user: user, recipe_type: recipe_type)

    # navigation
    visit root_path
    login_as (user)
    click_on 'Bolo de Cenoura'
    click_on 'Remover receita'

    #expect
    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content('Receita removida com sucesso')
    expect(current_path).to eq(root_path)
  end

  scenario 'and he is not the owner of the recipe' do

    #setup
    user = create(:user)
    another_user = create(:user, email:'another_user@gmail.com')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de Cenoura', user: user, recipe_type: recipe_type)

    # navigation
    visit root_path
    login_as (another_user)
    click_on 'Bolo de Cenoura'

    #expect
    expect(page).not_to have_link('Remover receita')
  end

end
