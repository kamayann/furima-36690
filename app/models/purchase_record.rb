class PurchaseRecord < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :buyer_information
end
