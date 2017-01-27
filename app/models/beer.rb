class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def average_rating
    sum = ratings.inject(0){ |sum, rating| sum + rating.score.to_f }
    average = (sum / ratings.size).round 2
  end

  def to_s
    return "#{name}, #{brewery.name}"
  end
end
