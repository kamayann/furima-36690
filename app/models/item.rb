class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  with_options presence: true do
    validates :image
    validates :name
    validates :info
    validates :price
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :item_status_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

  validates :name, length: { maximum: 40 }
  validates :info, length: { maximum: 1000 }
  validates :price, format: { with: /\A[0-9]+\z/ },
                    numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
