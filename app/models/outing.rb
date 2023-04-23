class Outing < ApplicationRecord
  has_many :contestant_outings
  has_many :contestants, through: :contestant_outings

  def contestant_count
    contestants.size
  end

  def contestant_names
    contestants.pluck(:name)
  end
end