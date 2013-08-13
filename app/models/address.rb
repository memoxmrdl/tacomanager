class Address < ActiveRecord::Base
  belongs_to :establishment
  after_validation :geocode

  geocoded_by :full_address

  def full_address
    [street, city, state, country, zip_code].compact.join(', ')
  end
end
