class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :establishment
  has_many :order_details
  has_many :users, through: :order_details

  validates_presence_of :name

  def total
    order_details.total
  end
end
