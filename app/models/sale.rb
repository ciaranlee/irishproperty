class Sale < ActiveRecord::Base
  attr_accessible :address, :county, :date, :description, :full_market_price, :lat, :lng, :postal_code, :price, :price_string, :size_description, :import_hash
end
