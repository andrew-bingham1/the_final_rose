require 'rails_helper'

RSpec.describe 'Contestant Show Page' do
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
    @outing_4 = @contestant_2.outings.create!(name: "Helicopter Ride", location: "Breckenridge, CO", date: "01/04/2020")
    @outing_5 = @contestant_3.outings.create!(name: "Kickball", location: "Denver, CO", date: "01/02/2020")
    @outing_6 = @contestant_3.outings.create!(name: "Hot Springs", location: "Steamboat Springs, CO", date: "01/03/2020")
  end

  describe 'User Story 3' do
    it 'can see a contestants name as well as the season number and season description that this contestant was on' do
      visit contestant_path(@contestant_5)

      within ("#contestant-info") do
        expect(page).to have_content(@contestant_5.name)
        expect(page).to have_content(@bachelorette_2.season_number)
        expect(page).to have_content(@bachelorette_2.description)
      end

      expect(page).to_not have_content(@contestant_1.name)
      expect(page).to_not have_content(@contestant_2.name)
      expect(page).to_not have_content(@contestant_3.name)
      expect(page).to_not have_content(@bachelorette_1.season_number)
    end

    it 'can see a list of names of the outings that this contestant has been on while on the show' do
      visit contestant_path(@contestant_1)
    
      within ("#contestant-outings") do
        expect(page).to have_content(@outing_1.name)
        expect(page).to have_content(@outing_2.name)
      end

      expect(page).to_not have_content(@outing_3.name)
      expect(page).to_not have_content(@outing_4.name)
    end

    it 'can click on an outing name and be taken to that outings show page' do
      visit contestant_path(@contestant_1)

      click_link("#{@outing_1.name}")

      expect(current_path).to eq(outing_path(@outing_1))

      visit contestant_path(@contestant_2)

      click_link("#{@outing_3.name}")

      expect(current_path).to eq(outing_path(@outing_3))
    end
  end
end
