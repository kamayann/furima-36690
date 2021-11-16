class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @buyer_purchase = BuyerPurchase.new
  end

  def create
    binding.pry
    @buyer_purchase = BuyerPurchase.new(buyer_purchase_params)
    if @buyer_purchase.valid?
      @buyer_purchase.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  
  def buyer_purchase_params
    params.require(:buyer_purchase).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id, purchase_record_id: purchase_record.id)
  end
end
