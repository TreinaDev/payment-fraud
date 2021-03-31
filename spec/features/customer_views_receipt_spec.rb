require 'rails_helper'

feature 'customer views receipt' do
  scenario 'successfully' do
    payment_method = create(:payment_method, name: 'Pix')
    payment = create(:payment)
    receipt = Receipt.create!(token_receipt: '123456789', number_installment: 1, payment_id: payment.id)

    expect(page).to have_content('Data: 10/10/2021')
    expect(page).to have_content('Número: 123456789')
    expect(page).to have_content('Forma de pagamento: Pix')
    expect(page).to have_content('Parcela: 1')
    expect(page).to have_content('Plano: Premium')
    expect(page).to have_content('Valor: 100.0')
    #expect(page).to have_content('Total de parcelas do plano: 5')

  end
end
