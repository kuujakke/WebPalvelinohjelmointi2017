class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  include AverageRating

  validates :score, numericality: {
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 50,
      only_integer: true
  }
  validates :name, presence: true

  def to_s
    return "#{name}, #{brewery.name}"
  end
end
