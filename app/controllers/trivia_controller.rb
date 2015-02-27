class TriviaController < ApplicationController
  def index
    @questions = Question.all
  end
end
