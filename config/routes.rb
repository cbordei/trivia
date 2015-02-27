Rails.application.routes.draw do
  root "trivia#index"
  resources :answer, only: [] do
    get :check_answer, :on => :member
  end
end
