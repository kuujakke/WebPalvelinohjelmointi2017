module TopRateable
  extend ActiveSupport::Concern
  include RatingAverage

  included do
    def self.top(n)
      sorted_by_rating_in_desc_order = self.all.sort_by{ |b| -(b.average_rating||0) }
      sorted_by_rating_in_desc_order.first n
    end
  end
end