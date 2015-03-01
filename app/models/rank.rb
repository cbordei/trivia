class Rank

  attr_reader :rank_name  

  RANKS = [
    "Gabor",
    "Borfas",
    "Smenar",
    "Peste",
    "Baiat",
    "Frate",
    "Veteran"
  ]

  def initialize(score, quiz_length)
    @score = score
    @quiz_length = quiz_length
  end

  def rank_name
    @rank_name ||= RANKS[closest_percentage]
  end

  private

  def percentage
    ((@score * 100) / @quiz_length).round(2)
  end

  def closest_percentage
    i = ((percentage.to_f * RANKS.count)/100).round
    i -= 1 if i == RANKS.count
    i 
  end
end
