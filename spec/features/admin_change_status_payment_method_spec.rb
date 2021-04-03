require 'rails_helper'

feature 'Admin change payment method status' do
  scenario 'must be signed in' do
    admin = FactoryBot.create(:user)

    login_as admin
    visit root_path

    expect(page).to have_content("Olá #{admin.first_name}")
  end

  scenario 'Active status' do
    payment_method = create(:payment_method, name: 'Cartão Crédito', status: :inactive)

    visit root_path
    click_on 'Gerenciar Meio de Pagamento'
    click_on payment_method.name
    click_on 'Ativar'

    payment_method.reload
    expect(payment_method.status).to eq('active')
  end

  scenario 'Inactive status' do
    payment_method = create(:payment_method, name: 'Cartão Crédito', status: :active)

    visit root_path
    click_on 'Gerenciar Meio de Pagamento'
    click_on payment_method.name
    click_on 'Desativar'

    payment_method.reload
    expect(payment_method.status).to eq('inactive')
  end
end
