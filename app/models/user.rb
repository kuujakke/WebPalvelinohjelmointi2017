class User < ApplicationRecord
  has_many :ratings
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username,
            uniqueness: true,
            length: { minimum: 3, maximum: 30 }

  include AverageRating
end
