class OrderDetails < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  belongs_to :menu_item

  validates_associated :menu_item
  validates :quantity, numericality: { greater_than: 0 }
end
