Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/api/v1/customers/:customer_id/subscriptions', to: 'api/v1/customer_subscriptions#create'

  patch '/api/v1/customers/:customer_id/subscriptions/:id', to: 'api/v1/customer_subscriptions#update'

  get '/api/v1/customers/:customer_id/subscriptions', to: 'api/v1/customer_subscriptions#index'
end
