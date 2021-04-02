require 'rails_helper'

feature 'Admin see payments' do
  scenario 'must be signed in' do
    admin = FactoryBot.create(:user)
    login_as admin

    visit root_path

    expect(page).to have_content("Olá #{admin.first_name}")
  end

  scenario 'succesfully' do
    admin = FactoryBot.create(:user)

    payment_method = create(:payment_method, name: 'Cartão Crédito', status: :active)
    payment = create(:payment, cpf: '12345678900', payment_method: payment_method)
    login_as admin

    visit root_path
    click_on 'Consultar Pagamentos'
    click_on payment.cpf

    expect(current_path).to eq(payment_path(payment))
    expect(page).to have_content(payment.cpf)
    expect(page).to have_content(payment.customer_token)
    expect(page).to have_content(payment.status)
    expect(page).to have_link('Voltar')
  end

  scenario 'and dont show button receipt if pending' do
    admin = FactoryBot.create(:user)

    payment_method = create(:payment_method, name: 'Cartão Crédito', status: :active)
    payment = create(:payment, cpf: '12345678900', payment_method: payment_method)
    login_as admin

    visit root_path
    click_on 'Consultar Pagamentos'
    click_on payment.cpf

    expect(current_path).to eq(payment_path(payment))
    expect(page).not_to have_link('Ver Recibo')
  end

  xscenario 'and show receipt' do
    admin = FactoryBot.create(:user)
    login_as admin
    visit root_path
  end
end
