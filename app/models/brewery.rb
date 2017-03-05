class Brewery < ApplicationRecord

  include TopRateable

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year,
            numericality: {
                greater_than_or_equal_to: 1024,
                less_than_or_equal_to: Proc.new { Time.now.year },
                only_integer: true
            }
  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

  def count
    beers.size
  end

  def active
    active? ? "yes" : "no"
  end

end