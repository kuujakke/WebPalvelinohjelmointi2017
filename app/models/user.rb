class User < ApplicationRecord
  has_many :ratings
  include AverageRating
end
