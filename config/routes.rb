Rails.application.routes.draw do

  # root to: "posts#index"
  get "admin/homes/top" => "admin/homes#top", as: "top"

  namespace :admin do
    resources :posts, only: [:show, :index, :edit, :creat, :new, :update, :destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :donations, only: [:show]
  end

  get "public/homes/about" => "public/homes#about"

  namespace :public do
    resources :posts, only: [:new, :index, :show]
    resources :customers, only: :show
    post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
    delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
    get "customers/mypage" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
    get "customers/withdrawal" => "customers#withdrawal"
    patch "customers/unsubscribe" => "customers#unsubscribe"
    resources :donations, only: [:update, :index, :new, :create]
    post "donations/confirm" => "donations#confirm"
    get "donations/complete" => "donations#complete"
    resources :donation_details, only: [:index, :show]
  end

  post '/customers/guest_sign_in', to: 'customers/sessions#new_guest'

  devise_for :customer, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
