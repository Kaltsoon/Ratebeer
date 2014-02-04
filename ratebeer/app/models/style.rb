class Style < ActiveRecord::Base
  attr_accessible :name
  has_many :beers
  def to_s
  	return name
  end
end
