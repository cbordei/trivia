class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers
  validates :question, presence: true 
  validate :one_answer_is_correct

  def random_answers
    answers.shuffle
  end

  def correct_answer
    answers.where("is_correct=true").first
  end

  def one_answer_is_correct
    unless answers.collect {|a| a.is_correct}.include?(true)
      errors.add(:answers, "At least one answer has to be correct")
    end    
  end
end
