class Style < ApplicationRecord
  include TopRateable
  has_many :beers
  has_many :ratings, through: :beers
end
