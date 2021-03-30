require 'rails_helper'

feature 'Admin edit a payment method' do
  xscenario 'must be signed in' do
    visit root_path
  end

  scenario 'succesfully' do
    payment_method = create(:payment_method, name: 'Cartão Crédito')

    visit root_path
    click_on 'Gerenciar Meio de Pagamento'
    click_on payment_method.name
    click_on 'Editar'

    fill_in 'Nome', with: 'Meio de Teste'
    fill_in 'Número Máximo de Parcelas', with: 10
    fill_in 'Código', with: 'TEST'
    click_on 'Salvar'

    expect(current_path).to eq(payment_method_path(payment_method))
    expect(page).to have_content('Meio de Teste')
    expect(page).to have_content('10')
    expect(page).to have_content('TEST')
    expect(page).to have_link('Voltar')
  end

  scenario 'fields can not be blank' do
    payment_method = create(:payment_method, name: 'Cartão Crédito')

    visit root_path
    click_on 'Gerenciar Meio de Pagamento'
    click_on payment_method.name
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Número Máximo de Parcelas', with: ''
    fill_in 'Código', with: ''
    click_on 'Salvar'

    expect(current_path).to eq(payment_method_path(payment_method))
    # TODO: Fazer os testes com a mensagem da tela
    expect(page).to have_content('Erro ao Salvar')
  end
end
