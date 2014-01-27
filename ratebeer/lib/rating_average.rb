module RatingAverage
	def average_rating
      # injektiolla:
      #
      # sum=ratings.inject(0.0){|sum, rating| sum + rating.score }
      # avg=sum/ratings.count
      #
  		if(ratings.count==0)
  			return 0
  		end
    	sum=0
    	ratings.each do |rating|
      		sum+=rating.score
    	end
    	return sum/ratings.count.to_f
	end
end