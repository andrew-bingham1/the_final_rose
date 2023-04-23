require 'rails_helper'

RSpec.describe Contestant, type: :model do
  describe 'relationships' do
    it {should belong_to :bachelorette}
  end

  describe 'instance methods' do
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

    it '#bachelorette_info' do
      expect(@contestant_1.bachelorette_info.name).to eq(@bachelorette_1.name)
      expect(@contestant_3.bachelorette_info.season_number).to eq(@bachelorette_2.season_number)
    end

    it '#contestant_outings' do 
      expect(@contestant_1.contestant_outings).to eq([@outing_1, @outing_2])
      expect(@contestant_2.contestant_outings).to eq([@outing_3, @outing_4])
      expect(@contestant_3.contestant_outings).to eq([@outing_5, @outing_6])
    end
  end
end
