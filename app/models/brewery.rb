class Brewery < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  include AverageRating

  validates :name, presence: true
  validates :year, numericality: {
      greater_than_or_equal_to: 1024,
      less_than_or_equal_to: 2017,
      only_integer: true
  }

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def to_s
    return "#{name}"
  end
end