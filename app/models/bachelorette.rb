class Bachelorette <ApplicationRecord
  has_many :contestants
  
  def bachelorette_contestants
    contestants
  end

  def average_contestant_age
    contestants.average(:age).round(2)
  end
end
