require 'rails_helper'

feature 'visitor send message to a friend ' do
  scenario 'successfully' do
    user = create(:user, email: 'thiago@gmail.com')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bananada de goiaba',
                             user: user,
                             recipe_type: recipe_type)

    login_as user
    visit root_path
    click_on recipe.title
    fill_in 'Email', with: 'bruna@gmail.com'
    fill_in 'Mensagem', with: 'Vamos preparar esta receita?'
    expect(RecipesMailer).to receive(:share)
      .with('bruna@gmail.com', 'Vamos preparar esta receita?',
            recipe.id).and_call_original
    click_on 'Enviar'

    expect(page).to have_content 'Receita enviada para bruna@gmail.com'
    expect(current_path).to eq recipe_path(recipe)
  end
end
