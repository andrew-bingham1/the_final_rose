require 'rails_helper'

RSpec.describe Bachelorette, type: :model do
  describe 'relationships' do
    it {should have_many :contestants}
  end

  describe 'instance methods' do
    before (:each) do
      @bachelorette_1 = Bachelorette.create!(name: "Hannah Brown", season_number: 15, description: "The Most Dramatic Season Yet!")
      @bachelorette_2 = Bachelorette.create!(name: "Kaitlyn Bristowe", season_number: 11, description: "A Pretty Good Season")
      @contestant_1 = @bachelorette_1.contestants.create!(name: "Peter Kraus", age: 29, hometown: "Westlake Village, CA")
      @contestant_2 = @bachelorette_1.contestants.create!(name: "Tyler Cameron", age: 26, hometown: "Miami, FL")
      @contestant_3 = @bachelorette_2.contestants.create!(name: "Nick Viall", age: 39, hometown: "Chicago, IL")
      @contestant_4 = @bachelorette_2.contestants.create!(name: "Arie Luyendyk Jr.", age: 29, hometown: "Scottsdale, AZ")
      @contestant_5 = @bachelorette_2.contestants.create!(name: "Ben Higgins", age: 29, hometown: "Denver, CO")
    end

    it '#bachelorette_contestants' do
      expect(@bachelorette_1.bachelorette_contestants).to eq([@contestant_1, @contestant_2])
      expect(@bachelorette_2.bachelorette_contestants).to eq([@contestant_3, @contestant_4, @contestant_5])
    end

    it '#average_contestant_age' do
      expect(@bachelorette_1.average_contestant_age).to eq(27.5)
      expect(@bachelorette_2.average_contestant_age).to eq(32.33)
    end

    it '#hometowns' do
      expect(@bachelorette_1.hometowns).to eq(["Westlake Village, CA", "Miami, FL"])
      expect(@bachelorette_2.hometowns).to eq(["Chicago, IL", "Scottsdale, AZ", "Denver, CO"])
      @contestant_6 = @bachelorette_2.contestants.create!(name: "Colton Underwood", age: 29, hometown: "Denver, CO")
      expect(@bachelorette_2.hometowns).to eq(["Chicago, IL", "Scottsdale, AZ", "Denver, CO"])
    end
  end
end
