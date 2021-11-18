class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @buyer_purchase = BuyerPurchase.new
  end

  def create
    @item = Item.find(params[:item_id])
    @buyer_purchase = BuyerPurchase.new(buyer_purchase_params)
    if @buyer_purchase.valid?
      pay_item
      @buyer_purchase.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def buyer_purchase_params
    params.require(:buyer_purchase).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: buyer_purchase_params[:token],
      currency: 'jpy'
    )
  end
end
