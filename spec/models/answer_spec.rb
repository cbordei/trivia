require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:answer) { Answer.new }

  context "validation" do
    it "fails validation of presence" do
      expect(answer.save).to eq(false)
      expect(answer.errors.messages).to have_key(:answer)
    end
  end
end
