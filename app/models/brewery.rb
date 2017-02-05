class Brewery < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  include AverageRating

  validates :name, presence: true
  validates :year,
            numericality: {
                greater_than_or_equal_to: 1024,
                only_integer: true
            }
  validate :year_cannot_be_in_the_future

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def to_s
    return "#{name}"
  end

  def year_cannot_be_in_the_future
    errors.add(:year) unless year <= Time.current.year
  end
end