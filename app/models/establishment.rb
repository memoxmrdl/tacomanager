class Establishment < ActiveRecord::Base
  has_many :address

  has_many :menu_items
  has_many :orders
  has_many :comments
  has_many :images

  acts_as_votable

  validates_uniqueness_of :name
  validates_presence_of :name

  accepts_nested_attributes_for :images, allow_destroy: true
end
