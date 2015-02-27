object false

child @questions => "questions" do |questions|
  attributes :question
  child :random_answers do
    attributes :id, :answer
  end
end

