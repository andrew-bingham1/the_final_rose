require 'rails_helper'

RSpec.describe 'Bachelorette Show Page', type: :feature do
  before (:each) do
    @bachelorette_1 = Bachelorette.create!(name: "Hannah Brown", season_number: 15, description: "The Most Dramatic Season Yet!")
    @bachelorette_2 = Bachelorette.create!(name: "Kaitlyn Bristowe", season_number: 11, description: "A Pretty Good Season")
    @contestant_1 = @bachelorette_1.contestants.create!(name: "Peter Kraus", age: 29, hometown: "Westlake Village, CA")
    @contestant_2 = @bachelorette_1.contestants.create!(name: "Tyler Cameron", age: 26, hometown: "Miami, FL")
    @contestant_3 = @bachelorette_2.contestants.create!(name: "Nick Viall", age: 39, hometown: "Chicago, IL")
    @contestant_4 = @bachelorette_2.contestants.create!(name: "Arie Luyendyk Jr.", age: 39, hometown: "Scottsdale, AZ")
    @contestant_5 = @bachelorette_2.contestants.create!(name: "Ben Higgins", age: 29, hometown: "Denver, CO")
  end

  describe 'User Story 1' do
    it "When I visit a bachelorette show page, I see that bachelorette's name, season number, and description of season" do
      visit bachelorette_path(@bachelorette_1)

      within("#bachelorette-info") do
        expect(page).to have_content(@bachelorette_1.name)
        expect(page).to have_content(@bachelorette_1.season_number)
        expect(page).to have_content(@bachelorette_1.description)
      end 

      expect(page).to_not have_content(@bachelorette_2.name)
      expect(page).to_not have_content(@bachelorette_2.season_number)
      expect(page).to_not have_content(@bachelorette_2.description)
    end

    it "I also see a link to see that bachelorette's contestants" do
      visit bachelorette_path(@bachelorette_1)

      within("#bachelorette-info") do
        expect(page).to have_link("Contestants")
      end
    end

    it "When I click on that link, I'm taken to the bachelorette's contestants page and I can see only that bachelorette's contestants" do
      visit bachelorette_path(@bachelorette_1)

      click_link("Contestants")

      expect(current_path).to eq(bachelorette_contestants_path(@bachelorette_1))
    end
  end
end


# I'm taken to "/bachelorettes/:bachelorette_id/contestants"
# and I can see only that bachelorette's contestants