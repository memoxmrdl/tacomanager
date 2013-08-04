class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :establishment
  belongs_to :food

  has_attached_file :image,
    styles: { small: '46x46>', medium: '360x360>', thumb: '190x190>' }

  validates_attachment :image, presence: true,
    size: { less_than: 1.megabytes },
    content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png'] }
end
