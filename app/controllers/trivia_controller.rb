class TriviaController < ApplicationController
  def index
    @questions = Question.all.offset(rand(20)).last(ENV['QUIZ_LENGTH']).shuffle    
  end

  def ranking
    @rank = Rank.new(params[:score].to_i, ENV['QUIZ_LENGTH'].to_i)
  end
end
