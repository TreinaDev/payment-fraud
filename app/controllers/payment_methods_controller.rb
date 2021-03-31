class PaymentMethodsController < ApplicationController
  def index
    @payment_methods = PaymentMethod.all
  end

  def show
    @payment_method = PaymentMethod.find(params[:id])
  end

  def new
    @payment_method = PaymentMethod.new
  end

  def create
    @payment_method = PaymentMethod.new(payment_method_params)

    if @payment_method.save
      redirect_to payment_method_path(@payment_method)
    else
      render :new
    end
  end

  def edit
    @payment_method = PaymentMethod.find(params[:id])
  end

  def update
    @payment_method = PaymentMethod.find(params[:id])

    if @payment_method.update(payment_method_params)
      redirect_to payment_method_path(@payment_method)
    else
      render :edit
    end
  end

  def disable
    @payment_method = PaymentMethod.find(params[:id])
    @payment_method.inactive!
    render :show
  end

  def activate
    @payment_method = PaymentMethod.find(params[:id])
    @payment_method.active!
    render :show
  end

  private

  def payment_method_params
    params.require(:payment_method).permit(:name, :max_installments, :code)
  end
end
