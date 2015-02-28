require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:answer) { Answer.new }
  let(:question) { Question.new }

  context "validation" do
    it "fails validation of presence" do
      expect(question.save).to eq(false)
      expect(question.errors.messages).to have_key(:question)
    end

    it "fails - one answer has to be correct" do
      answer.answer= "test"
      question.question = "test?"
      question.answers << answer

      expect(question.save).to eq(false)
      expect(question.errors.messages).to have_key(:answers)
    end
  end
end
