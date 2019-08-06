Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'sessions#new'
  resources :sessions
  resources :articles

  post "/articles/:id/create_answer", to: "articles#create_answer"
  post "/update_answer/:answer_id", to: "articles#update_answer"
  
  get "/articles/:id/survey", to: "articles#survey"
  post "/survey_answer/:answer_id", to: "articles#survey_answer"

  get "/articles/:id/finish", to: "articles#finish"
  get "/wrong", to: "application#wrong"
  
end
