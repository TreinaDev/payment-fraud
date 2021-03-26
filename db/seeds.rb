# Payment_methods
FactoryBot.create(:payment_method)
FactoryBot.create(:payment_method, { name: 'Boleto', 
                                      code: 'BOLET', 
                                      max_installments: 1 })

FactoryBot.create(:payment_method, { name: 'Pix',
                                      code: 'PIX',
                                      max_installments: 1 })

# Payment

