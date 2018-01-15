require 'rails_helper'

feature 'User sign in' do
  scenario 'using an email and password' do

    #setup
    user = create(:user)

    #navigation
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

     click_on 'Log in'

   #expect
   expect(page).to have_content("Bem-vindo #{user.email}")
   expect(page).not_to have_link('Entrar')
  end

  scenario 'and sign out' do

    #setup
    user = create(:user)

    #navigation
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Log in'

   #expect
   click_on 'Sair'
   expect(page).to have_content("Saiu com sucesso")

  end
end
