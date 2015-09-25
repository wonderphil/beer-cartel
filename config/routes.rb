Rails.application.routes.draw do

  root                      'static_pages#home'
  get     'help'         => 'static_pages#help'
  get     'contact'      => 'static_pages#contact'
  get     'signup'       => 'users#new'
  get     'new-beer'     => 'beers#new'
  get     'login'        => 'sessions#new'
  get     'new-meeting'  => 'meetings#new'


  post    'login'     => 'sessions#create'
  delete  'logout'    => 'sessions#destroy'

  resources :users
  resources :meetings
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  
  resources :beers do
    collection do
      get 'search'
    end
    resources :reviews,             except: [:show, :index]
  end

end
