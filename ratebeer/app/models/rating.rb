class Rating < ActiveRecord::Base
  attr_accessible :beer_id, :score, :user_id
  belongs_to :beer
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :beer_id
  validates_numericality_of :score, {
  	greater_than_or_equal: 1,
  	less_than_or_equal_to: 50,
  	only_inter: true
  }
  def to_s
  	Beer.find(beer_id).name+" "+score.to_s
  end
end