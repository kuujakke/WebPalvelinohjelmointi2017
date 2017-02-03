class Rating < ApplicationRecord
  belongs_to :beer
  belongs_to :user

  def to_s
    return "#{beer.name} #{score}"
  end
end
