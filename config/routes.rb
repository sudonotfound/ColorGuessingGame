Rails.application.routes.draw do #Railsアプリケーションのルーティング設定を開始
  
  root 'game#index' 
  #アプリケーションのルートURL（"/"）にアクセスしたとき、GameControllerのindexアクションを呼び出します。
  post 'game/check_answer',to:'game#check_answer', as: 'check_answer'
  #/check_answerというURLにPOSTリクエストを送る
  #GameControllerのcheck_answerアクションが呼び出される
  post 'game/reset', to: 'game#reset' , as: 'reset'
  #/check_answerというURLにPOSTリクエストを送ると、
  #GameControllerのcheck_answerアクションが呼び出されます。
  post 'game/new_question', to: 'game#new_question' , as: 'new_question'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
