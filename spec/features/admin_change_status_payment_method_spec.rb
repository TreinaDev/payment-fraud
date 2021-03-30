require 'rails_helper'

feature 'Admin change payment method status' do
  xscenario 'must be signed in' do
    visit root_path
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
