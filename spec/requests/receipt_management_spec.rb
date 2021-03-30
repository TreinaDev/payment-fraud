require 'rails_helper'

context 'GET payment' do
  it 'should render a payment information' do
    payment_method = create(:payment_method)
    payment = create(:payment)

    receipt = Receipt.create!(token_receipt: '123456789-1', number_installment: 1, payment_id: payment.id)

    expect(response).to have_http_status(:ok)
    expect(json_response[:token_receipt]).to eq('123456789-1')
    expect(json_response[:payment.cpf]).to eq('123.123.123-12')
    expect(json_response[:number_installment]).to eq('1')
  end
end