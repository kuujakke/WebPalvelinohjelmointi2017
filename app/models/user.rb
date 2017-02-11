class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true,
  length: { minimum: 3, maximum: 30 }

  validates :password, length: { minimum: 4}
  validates :password, format: { with: /([A-Z].*\d)|(\d.*[A-Z].*)/,
  message: "should contain one number and one capital letter" }

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    ratings.joins(:beer).group('beers.style').average(:score).sort_by(&:last).last.first
  end

  def favorite_brewery
    return nil if ratings.empty?
    Brewery.find(ratings.joins(:beer).group('beers.brewery_id').average(:score).sort_by(&:last).last.first).name
  end
end