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

  def initialize(score)
    @score = score.to_i
  end

  def rank_name
    @rank_name ||= RANKS[closest_percentage] 
  end

  private

  def questions_count
    @questions_count ||= Question.count
  end

  def percentage
    ((@score * 100) / questions_count).round(2)
  end

  def closest_percentage
    (1..7).min_by {|x| (x.to_f - percentage/100).abs}
  end

  
end
