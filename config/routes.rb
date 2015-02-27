Rails.application.routes.draw do
  root "trivia#index"
  get "trivia/ranking/:score" => "trivia#ranking"
  resources :answer, only: [] do
    get :check_answer, :on => :member
  end
end
