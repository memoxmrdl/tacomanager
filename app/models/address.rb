class Address < ActiveRecord::Base
  belongs_to :establishment
  after_validation :geocode

  geocoded_by :address

  def address
    [street, city, state, country, zip_code].compact.join(', ')
  end
end
