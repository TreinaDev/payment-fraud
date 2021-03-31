class ReceiptsController < ApplicationController
  layout 'receipts' 
  def show
    @receipt = Receipt.find(params[:id])
  end

  def create
    # TODO receipt.payment_id recebe payment.id
  end
end