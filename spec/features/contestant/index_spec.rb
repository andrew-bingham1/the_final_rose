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
        expect(page).to have_content(@contestant_1.age)
        expect(page).to have_content(@contestant_1.hometown)
      end

      within("#contestant-#{@contestant_2.id}") do
        expect(page).to have_content(@contestant_2.name)
        expect(page).to have_content(@contestant_2.age)
        expect(page).to have_content(@contestant_2.hometown)
      end

      expect(page).to_not have_content(@contestant_3.name)
      expect(page).to_not have_content(@contestant_4.name)
      expect(page).to_not have_content(@contestant_5.name)
    end
  end
end