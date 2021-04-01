require 'rails_helper'

feature 'customer views receipt' do
  scenario 'successfully' do
    plans_json = File.read(Rails.root.join('spec/support/apis/plans.json'))
    plans_double = double('faraday_response', status: 200, body: plans_json)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/plans')
                                   .and_return(plans_double)

    create(:payment_method, name: 'Pix')
    payment = create(:payment, plan_price: '100.0', status: 'approved')
    receipt = Receipt.create!(token_receipt: '123456789', number_installment: 1,
                              payment_id: payment.id, created_at: '2021-03-30 02:00:14 -0300')

    visit receipt_path(receipt.id)

    expect(page).to have_content('Número do recibo 123456789')
    expect(page).to have_content('Data 30/03/2021')
    expect(page).to have_content('Forma de pagamento Pix')
    expect(page).to have_content('Parcela 1')
    expect(page).to have_content('Plano Smart')
    expect(page).to have_content('Valor R$ 100,00')
    expect(page).to have_content('Status do pagamento aprovado')
    # expect(page).to have_content('Total de parcelas do plano: 5')
  end
end
