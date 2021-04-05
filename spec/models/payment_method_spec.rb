require 'rails_helper'

describe PaymentMethod do
  context 'validation' do
    it 'attributes cannot be blank' do
      payment_method = PaymentMethod.new

      expect(payment_method.valid?).to eq(false)
      expect(payment_method.errors.count).to eq(3)
    end

    it 'create a valid payment method' do
      payment_method = create(:payment_method)

      expect(payment_method).to be_valid
    end
  end

  context 'Payment method status' do
    it 'by default should be 0 (inactive)' do
      payment_method = create(:payment_method)

      expect(payment_method.status).to eq('inactive')
    end

    it 'is active when a Admin activate' do
      payment_method = create(:payment_method)

      payment_method.active!

      expect(payment_method.status).to eq('active')
    end
  end
end
