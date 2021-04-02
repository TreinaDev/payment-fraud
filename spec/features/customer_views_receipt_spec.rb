require 'rails_helper'

feature 'customer views receipt' do
  scenario 'successfully' do
    create(:payment_method, name: 'Pix')
    smart = Plan.new(name: 'Plano Smart')
    allow(Plan).to receive(:all).and_return([smart])
    payment = create(:payment, plan_id: 1, plan_price: '100.0', status: 'approved')
    receipt = Receipt.create!(token_receipt: '123456789', number_installment: 1,
                              payment_id: payment.id, created_at: '2021-03-30 02:00:14 -0300')

    visit receipt_path(receipt.token_receipt)

    expect(page).to have_content('Número do recibo 123456789')
    expect(page).to have_content('Data 30/03/2021')
    expect(page).to have_content('Forma de pagamento Pix')
    expect(page).to have_content('Parcela 1')
    expect(page).to have_content('Plano Smart')
    expect(page).to have_content('Valor R$ 100,00')
    expect(page).to have_content('Status do pagamento aprovado')
    # expect(page).to have_content('Total de parcelas do plano: 5')
  end

  it 'with error if receipt doesnt exist' do
    create(:payment_method)
    Plan.new(name: 'Plano Smart')
    allow(Plan).to receive(:all).and_return([])
    payment = create(:payment, status: 'approved')
    Receipt.create!(token_receipt: '123456789', number_installment: 1,
                    payment_id: payment.id)

    visit receipt_path('999')

    expect(page).to have_content('Recibo não encontrado')
  end
end
