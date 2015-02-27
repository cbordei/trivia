class TriviaController < ApplicationController
  def index
    @questions = Question.all.shuffle    
  end
end
