class Brewery < ActiveRecord::Base
  attr_accessible :name, :year
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  validates_length_of :name, minimum: 1
  validates_numericality_of :year, {
  	creater_than_or_equal_to: 1042,
  	only_integer: true
  }
  include RatingAverage
end
