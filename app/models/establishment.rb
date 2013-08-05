class Establishment < ActiveRecord::Base
  has_many :address

  has_many :menu_items
  has_many :orders
  has_many :comments
  has_many :images

  validates_uniqueness_of :name
  validates_presence_of :user_id, :telephones, :address

  accepts_nested_attributes_for :images, allow_destroy: true
end
