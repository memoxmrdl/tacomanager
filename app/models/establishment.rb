require 'acts_as_votable'

class Establishment < ActiveRecord::Base
  belongs_to :user
  has_many :foods
  has_many :comments
  has_many :images

  acts_as_votable

  validates_uniqueness_of :name
  validates_presence_of :user_id, :telephones, :address

  accepts_nested_attributes_for :images, allow_destroy: true
end
