class TriviaController < ApplicationController
  def index
    @questions = Question.all.offset(rand(20)).last(ENV['QUIZ_LENGTH']).shuffle    
  end

  def ranking
    @rank = Rank.new(params[:score], ENV['QUIZ_LENGTH'])
  end
end
