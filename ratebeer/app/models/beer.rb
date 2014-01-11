class Beer < ActiveRecord::Base
  attr_accessible :brewery_id, :name, :style
  belongs_to :brewery
  has_many :ratings
  def get_brewery_name
    return Brewery.find(brewery_id).name
  end
  def average_rating
  	if(ratings.count==0)
  		return 0
  	end
    sum=0
    ratings.each do |rating|
      sum=sum+rating.score
    end
    return sum/ratings.count
  end
end
