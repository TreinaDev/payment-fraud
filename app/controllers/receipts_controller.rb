class ReceiptsController < ApplicationController
  layout 'receipts'
  def show
    @receipt = Receipt.find_by(token_receipt: params[:token])
    @plan = Plan.all[@receipt.payment.plan_id.to_i] if @receipt.present?
  end
end
