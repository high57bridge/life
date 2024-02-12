Rails.application.routes.draw do
  
  get "admin/homes/top" => "admin/homes#top", as: "top"
  
  namespace :admin do
    resources :posts, only: [:show, :index, :edit, :creat, :new, :update, :destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :donations, only: [:show]
  end
  
  root to: 'public/homes#top'
  get "public/homes/about" => "admin/homes#about", as: "about"
  
  namespace :public do
    resources :posts, only: [:new, :index, :show]
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
  
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
