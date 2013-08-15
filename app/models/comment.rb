class Comment < ActiveRecord::Base
  belongs_to :establishment
  belongs_to :user

  validates_presence_of :establishment_id, :comment
end
