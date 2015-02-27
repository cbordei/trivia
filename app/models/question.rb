class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy

  def random_answers
    answers.shuffle
  end

  def correct_answer
    answers.where("is_correct=true").first
  end
end
