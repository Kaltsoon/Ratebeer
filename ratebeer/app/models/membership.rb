class Membership < ActiveRecord::Base
  attr_accessible :user_id, :beer_club_id
  belongs_to :user
  belongs_to :beer_club
  validates_uniqueness_of :user_id, scope: :beer_club_id
end
