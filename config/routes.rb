Rails.application.routes.draw do

  get "admin/homes/top" => "admin/homes#top", as: "top"

  namespace :admin do
    resources :homes, only: [:show, :update]
    resources :posts, only: [:show, :index, :edit, :new, :create, :update, :destroy]
    resources :customers, only: [:index, :show, :edit, :update, :destroy]
    resources :donations, only: [:show]
  end

  root to: 'public/homes#top'
  get "/about" => "public/homes#about", as: "about"
  get "/complete" => "public/homes#complete", as: "complete"

  namespace :public do
    resources :homes, only: :create
    resources :posts, only: [:new, :index, :show] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resource :tags, only: [:create, :destroy]
  end

    resources :customers, only: :show
    resource :customers do
      get :mypage, action: :show
      get "information/edit", action: :edit
      get :withdrawal
      patch :information, action: :update
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

  devise_for :customer, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
devise_scope :customer do
  post '/customers/guest_sign_in', to: 'public/sessions#new_guest'
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
