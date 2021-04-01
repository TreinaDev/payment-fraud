class ReceiptsController < ApplicationController
  layout 'receipts' 
  def show
    @receipt = Receipt.find(params[:id])
    @plan = Plan.all[@receipt.payment.plan_id.to_i]
  end

  def create
    # TODO receipt.payment_id recebe payment.id
  end
end
#[.to_i]