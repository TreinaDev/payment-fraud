class PaymentsController < ApplicationController
  before_action :authenticate_user!, only: %i[index show]

  def index
    @payments = Payment.all
  end

  def show
    @payment = Payment.find(params[:id])
  end
end
