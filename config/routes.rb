Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :gifts do
    collection do
      get 'size'
    end
  end
  resources :gift_lists
end
