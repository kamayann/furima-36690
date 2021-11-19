class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    @buyer_purchase = BuyerPurchase.new
    if @item.user == current_user or @item.purchase_record.present?
      redirect_to root_path
    end
  end

  def create
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

  def set_item
    @item = Item.find(params[:item_id])
  end
end
