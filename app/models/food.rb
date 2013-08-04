class Food < ActiveRecord::Base
  belongs_to :establishment
  has_one :image
  has_many :orderfoods
  has_many :orders, through: :orderfoods

  validates_presence_of :establishment_id, :name, :price
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
