require 'rails_helper'

feature 'Admin create a payment method' do
  scenario 'must be signed in' do
    admin = FactoryBot.create(:user)
    login_as admin
    visit root_path

    expect(page).to have_content("Olá #{admin.first_name}")
  end

  scenario 'succesfully' do
    admin = FactoryBot.create(:user)
    login_as admin

    visit root_path
    click_on 'Gerenciar Meio de Pagamento'
    click_on 'Criar Novo Meio de Pagamento'

    fill_in 'Nome', with: 'Meio de Teste'
    fill_in 'Número Máximo de Parcelas', with: 10
    fill_in 'Código', with: 'TEST'
    click_on 'Salvar'

    expect(current_path).to eq(payment_method_path(PaymentMethod.last))
    expect(page).to have_content('Meio de Teste')
    expect(page).to have_content('10')
    expect(page).to have_content('TEST')
    expect(page).to have_link('Voltar')
  end

  scenario 'fields can not be blank' do
    admin = FactoryBot.create(:user)
    login_as admin

    visit root_path
    click_on 'Gerenciar Meio de Pagamento'
    click_on 'Criar Novo Meio de Pagamento'

    fill_in 'Nome', with: ''
    fill_in 'Número Máximo de Parcelas', with: ''
    fill_in 'Código', with: ''
    click_on 'Salvar'

    expect(current_path).to eq(payment_methods_path)
    # TODO: Fazer os testes com a mensagem da tela
    expect(page).to have_content('Erro ao Salvar')
  end
end
