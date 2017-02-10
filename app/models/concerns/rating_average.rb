module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    (ratings.map(&:score).inject(&:+)/ratings.count.to_f).round(2)
  end
end