require 'csv'

class Sale < ActiveRecord::Base
  attr_accessible :address, :county, :date, :description, :full_market_price, :lat, :lng, :postal_code, :price, :size_description, :import_hash, :county_id
  belongs_to :county

  def self.import_from_csv(filename)
    CSV.foreach(filename, :headers => true) do |row|
      create_from_csv_row(row)
    end
  end

  def county_name
    county.name
  end

  def self.create_from_csv_row(row)
    import_hash = Digest::SHA1.hexdigest(row.to_s)
    unless where(:import_hash => import_hash).any?
      row = row.to_hash.with_indifferent_access
      county = County.find_or_create_by_name(row["County"])
      params = {
        :date => Date.parse(row["Date of Sale (dd/mm/yyyy)"]),
        :address => row["Address"],
        :postal_code => row["Postal Code"],
        :county_id => county.id,
        :price => Money.parse(row["Price (\x80)"]).to_d.to_i,
        :full_market_price => row["Not Full Market Price"].downcase == "no",
        :description => row["Description of Property"],
        :size_description => row["Property Size Description"],
        :import_hash => import_hash
      }
      create params.merge(:import_hash => import_hash)
    end
  end
end
