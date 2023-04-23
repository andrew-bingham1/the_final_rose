require 'rails_helper'

RSpec.describe Outing, type: :model do
  describe 'relationships' do
    it {should have_many :contestant_outings}
    it {should have_many(:contestants).through(:contestant_outings)}
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
      @contestant_outing_4 = ContestantOuting.create!(contestant: @contestant_4, outing: @outing_2)
      @contestant_outing_5 = ContestantOuting.create!(contestant: @contestant_5, outing: @outing_3)
    end

    it '#contestant_count' do
      expect(@outing_1.contestant_count).to eq(1)
      expect(@outing_2.contestant_count).to eq(2)
      expect(@outing_3.contestant_count).to eq(2)

      @contestant_outing_6 = ContestantOuting.create!(contestant: @contestant_3, outing: @outing_3)

      expect(@outing_3.contestant_count).to eq(3)
    end

    it '#contestant_names' do
      expect(@outing_1.contestant_names).to eq(["Peter Kraus"])
      expect(@outing_2.contestant_names).to eq(["Peter Kraus", "Arie Luyendyk Jr."])
      expect(@outing_3.contestant_names).to eq(["Tyler Cameron", "Ben Higgins"])
    end
  end
end