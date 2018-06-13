Rails.application.routes.draw do
devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
devise_for :users, controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations'
}

root 'items#index'
resources :items
resources :genres, only: [:index, :new, :create, :edit, :update, :destroy]
resources :cart_items, only: [:index, :create, :edit, :update, :destroy]
resources :orders, only: [:index, :show, :new, :create, :edit, :update]
resources :order_items, only: [:new, :create]
resources :users, only: [:index, :show, :edit, :update, :destroy]
resources :admins, only: [:show, :edit, :update]
resources :contacts, only: [:index, :show, :new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
