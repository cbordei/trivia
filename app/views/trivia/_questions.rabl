object false

child @questions => "questions" do |questions|
  attributes :question
  child :answers do
    attributes :id, :answer
  end
end

