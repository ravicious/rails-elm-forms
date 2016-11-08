# frozen_string_literal: true
class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to orders_url, notice: "Order ##{@order.id} was successfully created."
    else
      render :new
    end
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: "Order ##{@order.id} was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_url, notice: "Order ##{@order.id} was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(
      :product_id, :quantity, :options, :unit_price, :shipping_price,
      :customer_name, :customer_email
    )
  end
end
