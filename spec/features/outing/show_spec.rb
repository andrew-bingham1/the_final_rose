require 'rails_helper'

RSpec.describe "Outing Show Page", type: :feature do
  before (:each) do
    @bachelorette_1 = Bachelorette.create!(name: "Hannah Brown", season_number: 15, description: "The Most Dramatic Season Yet!")
    @bachelorette_2 = Bachelorette.create!(name: "Kaitlyn Bristowe", season_number: 11, description: "A Pretty Good Season")
    @contestant_1 = @bachelorette_1.contestants.create!(name: "Peter Kraus", age: 29, hometown: "Westlake Village, CA")
    @contestant_2 = @bachelorette_1.contestants.create!(name: "Tyler Cameron", age: 26, hometown: "Miami, FL")
    @contestant_3 = @bachelorette_2.contestants.create!(name: "Nick Viall", age: 39, hometown: "Chicago, IL")
    @contestant_4 = @bachelorette_2.contestants.create!(name: "Arie Luyendyk Jr.", age: 39, hometown: "Scottsdale, AZ")
    @contestant_5 = @bachelorette_2.contestants.create!(name: "Ben Higgins", age: 29, hometown: "Denver, CO")
    @outing_1 = @contestant_1.outings.create!(name: "Hiking", location: "Breckenridge, CO", date: "01/01/2020")
    @outing_2 = @contestant_1.outings.create!(name: "Kickball", location: "Denver, CO", date: "01/02/2020")
    @outing_3 = @contestant_2.outings.create!(name: "Hot Springs", location: "Steamboat Springs, CO", date: "01/03/2020")
    @outing_4 = @contestant_3.outings.create!(name: "Hiking", location: "Breckenridge, CO", date: "01/01/2020")
    @contestant_outing_4 = ContestantOuting.create!(contestant: @contestant_1, outing: @outing_2)
    @contestant_outing_5 = ContestantOuting.create!(contestant: @contestant_5, outing: @outing_3)
    @contestant_outing_6 = ContestantOuting.create!(contestant: @contestant_2, outing: @outing_1)
  end

  describe 'User Story 4' do
    it "When I visit an outings show page I see that outings name, location, and date" do
      visit outing_path(@outing_1)

      within("#outing-info") do
        expect(page).to have_content(@outing_1.name)
        expect(page).to have_content(@outing_1.location)
        expect(page).to have_content(@outing_1.date)
      end
    end

    it "When I visit an outings show page I see a total count of contestants that were on this outing" do
      visit outing_path(@outing_1)

      within("#outing-info") do
        expect(page).to have_content("Count of Contestants: 2")
      end
    end

    it "When I visit an outings show page I see a list of all names of the contestants that went on this outing" do
      visit outing_path(@outing_1)

      within("#outing-contestants") do
        expect(page).to have_content(@contestant_1.name)
        expect(page).to have_content(@contestant_2.name)
      end
      
      expect(page).to_not have_content(@contestant_3.name)
      expect(page).to_not have_content(@contestant_4.name)
      expect(page).to_not have_content(@contestant_5.name)
  
    end
  end
end


# And I see a total count of contestants that were on this outing
# And I see a list of all names of the contestants that went on this outing

# (e.g.       Helicopter Ride
#             Location: Bali
#             Date: 09/12/19
#           Count of Contestants: 3
# Contestants: JoJo Fletcher, Kaitlyn Bristowe, Hannah Brown)