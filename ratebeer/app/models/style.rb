class Style < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :ratings, through: :beers
  has_many :beers
  
  include RatingAverage

  def to_s
  	return name
  end

  def self.highest_ratings
    return Style.includes(:ratings).all.sort_by{|style| -style.average_rating}.take(3)
  end

end
