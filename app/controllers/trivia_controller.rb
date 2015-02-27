class TriviaController < ApplicationController
  def index
    @questions = Question.all.shuffle    
  end

  def ranking
    @rank = Rank.new(params[:score])
  end
end
