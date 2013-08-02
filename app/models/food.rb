class Food < ActiveRecord::Base
  belongs_to :establishment
  has_one :image
  has_many :orderfoods
  has_many :orders, through: :orderfoods

  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
