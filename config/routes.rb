Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" } 
  root "trivia#index"
  get "trivia/ranking/:score" => "trivia#ranking"
  resources :answer, only: [] do
    get :check_answer, :on => :member
  end
  resources :questions
end
