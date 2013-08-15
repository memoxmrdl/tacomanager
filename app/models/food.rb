class Food < ActiveRecord::Base
  belongs_to :establishment
  has_many :order_details
  has_one :image

  accepts_nested_attributes_for :image

  validates_presence_of :name, :price
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
