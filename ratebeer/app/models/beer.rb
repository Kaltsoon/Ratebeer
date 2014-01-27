class Beer < ActiveRecord::Base
  attr_accessible :brewery_id, :name, :style
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  validates_length_of :name, minimum: 1, message: "Beer name can't be empty!"
  include RatingAverage
  def to_s
    return name+", "+brewery.name
  end
end
