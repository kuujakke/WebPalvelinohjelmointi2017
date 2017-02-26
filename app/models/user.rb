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

  def self.top(n)
    User.all.sort_by{ |u| -(u.ratings.count) }
  end

  def favorite_style
    favorite :style
  end

  def favorite_brewery
    favorite :brewery
  end

  def favorite(category)
    return nil if ratings.empty?

    rated = ratings.map{ |r| r.beer.send(category) }.uniq
    rated.sort_by { |item| -rating_of(category, item) }.first
  end

  def rating_of(category, item)
    ratings_of = ratings.select{ |r| r.beer.send(category)==item }
    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
  end

  def is_admin?
    if admin
      true
    else
      false
    end
  end

  def is_active?
    if active
      true
    else
      false
    end
  end

end