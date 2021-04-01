class ReceiptsController < ApplicationController
  layout 'receipts'
  def show
    @receipt = Receipt.find_by(token_receipt: params[:token])
    # @receipt = Receipt.find_by(params[:id])
    @plan = Plan.all[@receipt.payment.plan_id.to_i]
  end
end
