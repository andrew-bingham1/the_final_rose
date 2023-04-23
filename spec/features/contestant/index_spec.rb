require 'rails_helper'

RSpec.describe 'Contestant Index Page', type: :feature do
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
    it "I can see only that bachelorette's contestants" do
      visit bachelorette_contestants_path(@bachelorette_1)

      within("#contestant-#{@contestant_1.id}") do
        expect(page).to have_content(@contestant_1.name)
      end

      within("#contestant-#{@contestant_2.id}") do
        expect(page).to have_content(@contestant_2.name)
      end

      expect(page).to_not have_content(@contestant_3.name)
      expect(page).to_not have_content(@contestant_4.name)
      expect(page).to_not have_content(@contestant_5.name)
    end
  end

  describe 'User Story 2' do
    it "I see the names of that bachelorette's contestants along with the following information: -Age -Hometown" do
      visit bachelorette_contestants_path(@bachelorette_1)

      within("#contestant-#{@contestant_1.id}") do
        expect(page).to have_content(@contestant_1.name)
        expect(page).to have_content(@contestant_1.age)
        expect(page).to have_content(@contestant_1.hometown)
      end

      within("#contestant-#{@contestant_2.id}") do
        expect(page).to have_content(@contestant_2.name)
        expect(page).to have_content(@contestant_2.age)
        expect(page).to have_content(@contestant_2.hometown)
      end
    end

    it "I can click on any contestants name (as a link) to go to that contestants show page" do
      visit bachelorette_contestants_path(@bachelorette_1)

      click_link("#{@contestant_1.name}")

      expect(current_path).to eq(contestant_path(@contestant_1))
    end
  end

  describe 'User Story 6' do
    it "I see a UNIQUE list of all of the hometowns that these contestants are from" do
      visit bachelorette_contestants_path(@bachelorette_1)

      within("#contestant-hometowns") do
        expect(page).to have_content("These Contestants are from these hometowns: Westlake Village, CA, Miami, FL")
      end

      visit bachelorette_contestants_path(@bachelorette_2)
      
      within("#contestant-hometowns") do
        expect(page).to have_content("These Contestants are from these hometowns: Chicago, IL, Scottsdale, AZ, Denver, CO")
      end

      @contestant_6 = @bachelorette_2.contestants.create!(name: "Ben Higgins", age: 29, hometown: "Denver, CO")

      visit bachelorette_contestants_path(@bachelorette_2)

      within("#contestant-hometowns") do
        expect(page).to have_content("These Contestants are from these hometowns: Chicago, IL, Scottsdale, AZ, Denver, CO")
      end
    end
  end
end

# As a visitor,
# When I visit a bachelorette's contestants index '/bachelorettes/:bachelorette_id/contestants',

# I see a UNIQUE list of all of the hometowns that these contestants are from.

# (e.g. "These Contestants are from these hometowns: Denver, Aurora, San Diego, Boston")