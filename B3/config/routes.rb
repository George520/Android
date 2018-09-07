Rails.application.routes.draw do
  resources :posts do
    collection do
      get :search
    end

    get 'category(/:name)', name: /[a-zA-Z0-9]+/ ,on: :collection, to: 'posts#category', as: :category
    get 'time(/:month)', month: /[0-9]+/, on: :collection, to: 'posts#time', as: :time
  end
  root 'posts#index'


  get 'users/register',  to: 'users#register', as: :user_register
  post 'users/register', to: 'users#create'
  get 'users/login', to: 'users#new', as: :user_login
  post 'users/login', to: 'users#login'
  get 'users/personal_page', to: 'users#personal_page', as: :personal_page
  delete 'users/logout', to: 'users#destroy', as: :user_logout

  get 'admins/register', to: 'admins#register', as: :admin_register
  post 'admins/register', to: 'admins#create'
  get 'admins/login', to: 'admins#new', as: :admin_login
  post 'admins/login', to: 'admins#login'
  delete 'admins/logout', to: 'admins#destroy', as: :admin_logout
  get 'admins/lock', to: 'admins#lock', as: :admin_lock
  get 'admins/my_check', to: 'admins#my_check', as: :my_check
  get 'admins/check_index', to: 'admins#check_index', as: :check_index
  post 'admins/check', to: 'admins#check', as: :check
  get 'admins/check_show/(/:post_id)', post_id: /[0-9]+/, to: 'admins#check_show',as: :check_show

  post 'comments/create', to: 'comments#create', as: :comment_create
  get 'comments/index', to: 'comments#index', as: :comments
  post 'comments/check', to: 'comments#check', as: :check_comments

  post 'feedbacks/create', to: 'feedbacks#create', as: :feedback_create
  get 'feedbacks/index', to: 'feedbacks#index', as: :feedbacks

end
