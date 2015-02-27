class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy

  def random_answers
    answers.shuffle
  end
end
