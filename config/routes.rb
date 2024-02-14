Rails.application.routes.draw do

  get "admin/homes/top" => "admin/homes#top", as: "top"

  namespace :admin do
    resources :posts, only: [:show, :index, :edit, :creat, :new, :update, :destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :donations, only: [:show]
  end

  root to: 'public/homes#top'
  get "public/homes/about" => "public/homes#about"

  namespace :public do
    resources :posts, only: [:new, :index, :show] do
      resource :favorites, only: [:create, :destroy]
      resources :comments
    end

    resources :customers, only: :show

    resource :customers do
      get :mypage, action: :show
      get "information/edit", action: :edit
      patch :information, action: :update
      get :withdrawal
      patch :unsubscribe
    end

    resources :donations, only: [:update, :index, :new, :create] do
      collection do
        post :confirm
        get :complete
      end
    end
    
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
