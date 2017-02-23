module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    unless ratings.empty?
      ratings.map(&:score).inject(&:+) / ratings.count.to_f
    else
      0
    end
  end
end