Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/url_properties/redirect', to: 'url_properties#get_redirect'
      resources :url_properties
    end
  end
end
