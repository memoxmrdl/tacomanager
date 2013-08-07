class OrderDetails < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  belongs_to :food

  validates_associated :food
  validates :quantity, numericality: { greater_than: 0 }
end
