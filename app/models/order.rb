class Order < ActiveRecord::Base
  belongs_to :user
  has_many :orderfoods
  has_many :foods, through: :orderfoods
end
