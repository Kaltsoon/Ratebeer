module RatingAverage
	def average_rating
  		if(ratings.count==0)
  			return 0
  		end
    	sum=0
    	ratings.each do |rating|
      		sum+=rating.score
    	end
    	return sum/ratings.count
	end
end