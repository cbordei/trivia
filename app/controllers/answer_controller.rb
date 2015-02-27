class AnswerController < ApplicationController
  def check_answer
    @answer = Answer.find(params[:id])
    if @answer.is_correct
      render json: { answer_id: @answer.id, correct: true }, status: 200
    else
      render json: { answer_id: @answer.id, correct: false }, status: 422
    end 
  end
end
