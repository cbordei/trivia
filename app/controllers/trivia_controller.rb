class TriviaController < ApplicationController
  def index
    random_ids = Question.pluck(:id).sort_by { rand }.slice(0, ENV['QUIZ_LENGTH'].to_i)
    @questions = Question.where(:id => random_ids)
  end

  def ranking
    @rank = Rank.new(params[:score].to_i, ENV['QUIZ_LENGTH'].to_i)
  end
end
