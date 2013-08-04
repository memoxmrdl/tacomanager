class Comment < ActiveRecord::Base
  belongs_to :establishment

  validates_presence_of :establishment_id
end
