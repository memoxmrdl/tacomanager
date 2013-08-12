class OrderDetails < ActiveRecord::Base
  before_save :calculate_subtotal

  belongs_to :user
  belongs_to :order
  belongs_to :food

  validates_associated :food
  validates :quantity, numericality: { greater_than: 0 }

  class << self
    def subtotal
      sum(:subtotal)
    end

  end

  def calculate_subtotal
    self.subtotal = food.price * quantity
  end
end
