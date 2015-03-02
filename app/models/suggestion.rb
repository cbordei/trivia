class Suggestion < ActiveRecord::Base
  validates :suggestion, presence: true 
  validates :email, presence: true 
  validates_format_of :email,:with => Devise::email_regexp
end
