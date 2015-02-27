require 'rake'
require 'csv'

namespace :questions do
  desc "Perform an initial seed of questions"
  task :import, [:csv_file] => :environment do |t, args|
    CSV.foreach(args[:csv_file]) do |row|
      if row[0].present?
        q = Question.new(question: row[0])      
        if row[1].present?
          q.answers << Answer.new(answer: row[1], is_correct: true)
        end
        q.save
      end

      if row[1].present? && row[0] == nil
        q = Question.last
        q.answers << Answer.new(answer: row[1])
        q.save
      end
    end
  end
end