Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'sessions#new'
  resources :sessions
  resources :articles

  post "/articles/:id/create_tweet_answer", to: "articles#create_tweet_answer"
  post "/articles/:id/create_unmatch_answer", to: "articles#create_unmatch_answer"
  post "/create_highlight/:answer_id", to: "articles#create_highlight"
  post "/update_answer/:answer_id", to: "articles#update_answer"
  get "/task/:task_id/skip_answer", to: "articles#skip_answer"
  
  get "/articles/:id/task_revisit", to: "articles#task_revisit"
  get "/articles/:id/survey", to: "articles#survey"
  get "/articles/:id/post_survey", to: "articles#post_survey"

  post "/survey_answer/:task_id", to: "articles#survey_answer"

  get "/articles/:id/finish", to: "articles#finish"
  get "/wrong", to: "application#wrong"
  
  get "/export", to: "application#export"
  get "/logs", to: "logs#export"
  get "/answers", to: "answers#export"
  get "/tasks", to: "tasks#export"
  get "/surveyanswers", to: "surveyanswers#export"
end
