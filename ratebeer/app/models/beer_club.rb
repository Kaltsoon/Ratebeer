class BeerClub < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  attr_accessible :city, :founded, :name

  def to_s
  	return name
  end

  def confirmed_memberships
  	return memberships.where(confirmed: true)
  end

  def not_confirmed_memberships
  	return memberships.where(confirmed: false)
  end

  def confirmed_users
  	return memberships.where(confirmed: true).map{|m| m.user}
  end

end
