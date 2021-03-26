require 'rails_helper'

feature 'Admin sign in' do
  scenario 'successfuly' do 
    admin = User.create!(email: 'admin@smartflix.com.br', password: '123456')

    visit root_path
    within('form') do 
      fill_in 'E-mail', with: admin.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
  end
  
  scenario 'and logout' do
    admin = User.create!(email: 'admin@smartflix.com.br', password: '123456')

    visit root_path
    within('form') do
      fill_in 'E-mail', with: admin.email
      fill_in 'Senha', with: '123456'

      click_on 'Entrar'
    end

    click_on 'Sair'

    within('nav') do
      expect(page).not_to have_link 'Sair'
      expect(page).not_to have_content admin.email
    end
  end
end