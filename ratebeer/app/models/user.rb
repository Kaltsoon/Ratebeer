class User < ActiveRecord::Base
  attr_accessible :password, :username, :password_confirmation, :admin
  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  include RatingAverage
  has_secure_password
  validates_confirmation_of :password
  validates_uniqueness_of :username
  validates_length_of :password, minimum: 4
  validates_format_of :password, with: /(.*[0-9].*[A-Z].*)|(.*[A-Z].*[0-9].*)/
  validates_length_of :username, within: 3..15
  def to_s
  	return username
  end
  
  def favorite_style
    styles=ratings.map{|r| r.beer.style}.uniq
    max_score=-1
    max_style=nil
    styles.each do |s|
        score=average_of_style(s)
        if(score>max_score)
          max_score=score
          max_style=s
        end
    end
    return max_style
  end

  def favorite_brewery
    breweries=ratings.map{|r| r.beer.brewery}.uniq
    max_score=-1
    max_brewery=nil
    breweries.each do |b|  
      score=average_of_brewery(b.id)
      if(score>max_score)
        max_score=score
        max_brewery=b
      end
    end
    return max_brewery
  end

  private

  def average_of_brewery(brewery_id)
    sum=0
    count=0
    ratings.each do |r|
      if(r.beer.brewery.id==brewery_id)
        sum+=r.score
        count+=1
      end
    end
    return (count==0 ? 0 : sum/count.to_f)
  end

  def average_of_style(style)
    sum=0
    count=0
    ratings.each do |r|
      if(r.beer.style==style)
        sum+=r.score
        count+=1
      end
    end
    return (count==0 ? 0 : sum/count.to_f)
  end

end
