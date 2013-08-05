class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :establishment

  has_many :order_details
  has_many :users, through: :order_details
end
