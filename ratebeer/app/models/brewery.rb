class Brewery < ActiveRecord::Base
  attr_accessible :name, :year, :active, :beers
  
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  
  validates_length_of :name, minimum: 1
  validates_numericality_of :year, {
  	creater_than_or_equal_to: 1042,
  	only_integer: true
  }

  include RatingAverage

  scope :active, where(:active => true)
  scope :retired, where(:active => [nil, false])

  def self.highest_ratings
    return Brewery.includes(:ratings).all.sort_by{|brewery| -brewery.average_rating}.take(3)
  end

  def to_s
    return name
  end
end
