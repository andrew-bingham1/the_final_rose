class Contestant <ApplicationRecord
  belongs_to :bachelorette
  has_many :contestant_outings
  has_many :outings, through: :contestant_outings
  
  def bachelorette_info
    bachelorette
  end

  def contestant_outings
    outings
  end
end
