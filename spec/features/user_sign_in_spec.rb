require 'rails_helper'

feature 'User sign in' do
  scenario 'using an email and password' do
    user = create(:user)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Log in'

    expect(page).to have_css('h3', text: "Bem vindo #{user.email}")
    expect(page).not_to have_link('Entrar')
  end

  scenario 'and sign out' do
    user = create(:user)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Log in'

    click_on 'Sair'
    expect(page).to have_content('Saiu com sucesso')
  end
end
