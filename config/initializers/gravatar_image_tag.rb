GravatarImageTag.configure do |config|
  config.default_image           = "http://www.imagoo.com/images/no_user.png"
  config.filetype                = nil   # Set this if you require a specific image file format ['gif', 'jpg' or 'png'].  Gravatar's default is png
  config.include_size_attributes = true  # The height and width attributes of the generated img will be set to avoid page jitter as the gravatars load.  Set to false to leave these attributes off.
  config.rating                  = nil   # Set this if you change the rating of the images that will be returned ['G', 'PG', 'R', 'X']. Gravatar's default is G
  config.size                    = 32    # Set this to globally set the size of the gravatar image returned (1..512). Gravatar's default is 80
  config.secure                  = false # Set this to true if you require secure images on your pages.
end
