class County < ActiveRecord::Base
  attr_accessible :name
  has_many :sales

  def to_param
    name
  end
end
