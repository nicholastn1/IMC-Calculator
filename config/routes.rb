Rails.application.routes.draw do

  root to: 'imc#index'

  get 'imc/index'
  get 'imc/result'
  post 'imc/calculate'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
