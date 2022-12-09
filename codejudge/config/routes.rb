
Rails.application.routes.draw do
  post '/addition/form', to: 'student_groups#addition_from'
  post '/add_problem/form', to: 'problem_groups#add_problem_form'
  get '/remove_student_group', to: 'student_groups#remove_student_group'
  get '/remove_problem_group', to: 'problem_groups#remove_problem_group'
  post '/solution_upload_form_path', to: 'problems#solution_upload'
  post '/problems/:id', to: 'problems#update'
  get '/searchtag', to: 'problems#searchtag'


  resources :approved_requests
  resources :admins
  resources :questions
  resources :instructors
  resources :student_groups
  resources :problem_tags
  resources :tags
  resources :problem_groups
  resources :groups
  resources :languages
  resources :attempts
  resources :problems

  resources :groups do
    member do
      get 'details'
    end
  end

  resources :student_groups do
    member do
      get 'addition'
    end
  end

  resources :student_groups do
    member do
      post 'joinclass'
    end
  end


  resources :problem_groups do
    member do
      get 'addproblem'
    end
  end

  resources :problems do
    member do
      get 'solution'
    end
  end


  get 'errors/not_found'
  get 'errors/internal_server_error'
  get 'errors/forbidden'
  
  resources :users, only: [:index, :create, :edit, :update, :show, :destroy]
  resources :problems
  root 'welcome#index'
  post 'log_in', to: 'welcome#log_in'
  get 'log_in/create', to: 'welcome#log_in', as: :create_log_in
  delete 'log_out', to: 'welcome#log_out'
  get 'register', to: 'registrations#new'
  post 'register', to: 'registrations#create'
  get 'register/create', to: 'registrations#create', as: :create_register
  post 'color_mode', to: 'application#color_mode', as: :color_mode

  match "/403", to: "errors#forbidden", via: :all
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
end
