class Bachelorette <ApplicationRecord
  has_many :contestants
  
  def bachelorette_contestants
    contestants
  end
end
