Rails.application.routes.draw do

  get "admin/homes/top" => "admin/homes#top", as: "top"

  namespace :admin do
    resources :homes,     only: [:show, :update]
    resources :posts,     only: [:show, :index, :edit, :new, :create, :update, :destroy] do
      resources :comments,  only: :destroy
    end
    resources :customers, only: [:index, :show, :edit, :update, :destroy]
    resources :donations, only: :index
  end

  root to: 'public/homes#top'
  get "/about"    => "public/homes#about",    as: "about"
  get "/complete" => "public/homes#complete", as: "complete"

  namespace :public do
    get "search" => "searches#search"
    resources :homes,       only: :create
    resources :posts,       only: [:new, :index, :show] do
      resource  :favorites, only: [:create, :destroy]
      resources :comments,  only: [:create, :update, :destroy]
      resource  :bookmarks, only: [:create, :destroy]
      resource  :tags,      only: :create
      resources :maps,      only: [:index, :show]
    end
    
    get '/tag/:name' => 'tags#tag', as: "hashtag"

    resources :customers, only: :show
    resource :customers do
      get   :mypage, action: :show
      get   "information/edit", action: :edit
      get   :withdrawal
      patch :information, action: :update
      patch :unsubscribe
    end

    resources :donations, only: [:index, :new, :create, :update] do
      collection do
        get  :information
        post :confirm
        get  :complete
      end
    end
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

