Rails.application.routes.draw do

  root to: 'homepages#index'

  resources :passengers do
    resources :trips, except: [:index]
  end

  resources :drivers do
    member do
      post 'activate'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
