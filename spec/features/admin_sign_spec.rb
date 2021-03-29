require 'rails_helper'

feature 'Admin sign in' do
  scenario 'successfuly' do
    admin = FactoryBot.create(:user)

    visit root_path
    within('form') do
      fill_in 'E-mail', with: admin.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
  end

  scenario 'and logout' do
    admin = FactoryBot.create(:user)

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

  scenario 'incorrect email' do
    visit root_path
    within('form') do
      fill_in 'E-mail', with: 'qualquer@qualquer.com'
      fill_in 'Senha', with: '123456'

      click_on 'Entrar'
    end

    expect(page).to have_content('E-mail ou senha inválida.')
  end
end
