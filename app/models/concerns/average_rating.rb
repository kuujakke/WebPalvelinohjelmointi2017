module AverageRating
  extend ActiveSupport::Concern

  def average_rating
    return 0 if ratings.empty?
    average = ratings.map{|r| r.score}.sum / ratings.count.to_f
    average.round(2)
  end
end