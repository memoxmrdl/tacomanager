class Image < ActiveRecord::Base
  belongs_to :establishment
  belongs_to :food

  has_attached_file :image,
    default_url: 'http://findicons.com/files/icons/331/slate/48/food.png',
    styles: { small: '64x64#', medium: '360x360>', thumb: '190x190>' }

  validates_attachment :image,
    size: { less_than: 1.megabytes },
    content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png'] }
end
