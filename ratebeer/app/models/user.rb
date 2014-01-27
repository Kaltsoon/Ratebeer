class User < ActiveRecord::Base
  attr_accessible :password, :username, :password_confirmation
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
end
