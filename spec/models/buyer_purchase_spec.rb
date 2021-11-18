require 'rails_helper'

RSpec.describe BuyerPurchase, type: :model do
  describe '購入者情報の保存' do
    before do
      @buyer_purchase = FactoryBot.build(:buyer_purchase)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@buyer_purchase).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @buyer_purchase.building_name = ''
        expect(@buyer_purchase).to be_valid
      end
      it 'phone_numberが10桁なら保存できること' do
        @buyer_purchase.phone_number = '1234567890'
        expect(@buyer_purchase).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @buyer_purchase.postal_code = ''
        @buyer_purchase.valid?
        expect(@buyer_purchase.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @buyer_purchase.postal_code = '1234567'
        @buyer_purchase.valid?
        expect(@buyer_purchase.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'prefecture_idを1以外を選択していないと保存できないこと' do
        @buyer_purchase.prefecture_id = 1
        @buyer_purchase.valid?
        expect(@buyer_purchase.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @buyer_purchase.city = ''
        @buyer_purchase.valid?
        expect(@buyer_purchase.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空だと保存できないこと' do
        @buyer_purchase.house_number = ''
        @buyer_purchase.valid?
        expect(@buyer_purchase.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @buyer_purchase.phone_number = ''
        @buyer_purchase.valid?
        expect(@buyer_purchase.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが10、11桁以外だと保存できないこと' do
        @buyer_purchase.phone_number = '123456789'
        @buyer_purchase.valid?
        expect(@buyer_purchase.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenが空だと保存できないこと' do
        @buyer_purchase.token = nil
        @buyer_purchase.valid?
        expect(@buyer_purchase.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
