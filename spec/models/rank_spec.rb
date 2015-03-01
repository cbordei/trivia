require 'rails_helper'

RSpec.describe Rank, type: :model do
  let(:rank) { Rank.new(@score, @length)}
  context "rank name" do
    it "returns Gabor for score=1 length=30" do      
      @score = 1
      @length = 30
      expect(rank.rank_name).to eq("Gabor")
    end

    it "returns borfas for score=6 length=30" do      
      @score = 6
      @length = 30
      expect(rank.rank_name).to eq("Borfas")
    end

    it "returns frate for score=20 length=30" do      
      @score = 20
      @length = 30
      expect(rank.rank_name).to eq("Frate")
    end

    it "returns veteran for score=25 length=30" do      
      @score = 25
      @length = 30
      expect(rank.rank_name).to eq("Veteran")
    end

    it "returns veteran for score=30 length=30" do      
      @score = 30
      @length = 30
      expect(rank.rank_name).to eq("Veteran")
    end    
  end
end
