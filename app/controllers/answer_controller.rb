class AnswerController < ApplicationController
  def check_answer
    @answer = Answer.find(params[:id])
    if @answer.is_correct
      render json: { correct_answer_id: @answer.id }, status: 200
    else
      render json: { correct_answer_id: @answer.question.correct_answer.id, wrong_answer_id: @answer.id }, status: 422
    end 
  end
end
