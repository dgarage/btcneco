Rails.application.routes.draw do
  devise_for :admins, path: 'admins', controllers: {
    confirmations: 'admins/confirmations',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations',
    sessions: 'admins/sessions',
    unlocks: 'admins/unlocks'
  }
  authenticate :admin do
    get '/admin', to: 'admin#index', as: 'admin'
    get '/admin/reports', to: 'admin#reports'

    # Posts from Admin
    resources :posts

    # Settings
    get '/admin/settings', to: 'admin#settings', as: 'setting'
    patch '/admin/settings', to: 'admin#settings_update', as: 'setting_update'
    post '/admin/getPairing', to: 'admin#getPairing'
    get '/admin/email_templates', to: 'admin#email_templates', as: 'email_templates'
    patch '/admin/email_templates', to: 'admin#email_templates_update', as: 'email_templates_update'

    # Goals
    get '/admin/goals', to: 'goal#index', as: 'goals'
    get '/admin/goals/new', to: 'goal#new', as: 'new_goal'
    post '/admin/goals', to: 'goal#create'
    get '/admin/goals/:id', to: 'goal#show', as: 'goal'
    get '/admin/goals/:id/edit', to: 'goal#edit', as: 'edit_goal'
    patch '/admin/goals/:id', to: 'goal#update'
    delete '/admin/goals/:id', to: 'goal#destroy'

    # Tiers
    get '/admin/tiers', to: 'tier#index', as: 'tiers'
    get '/admin/tiers/new', to: 'tier#new', as: 'new_tier'
    post '/admin/tiers', to: 'tier#create'
    get '/admin/tiers/:id', to: 'tier#show', as: 'tier'
    get '/admin/tiers/:id/edit', to: 'tier#edit', as: 'edit_tier'
    patch '/admin/tiers/:id', to: 'tier#update'
    delete '/admin/tiers/:id', to: 'tier#destroy'

    # Subscriptions
    get '/admin/subscriptions', to: 'subscription#index', as: 'subscriptions'
    get '/admin/subscriptions/new', to: 'subscription#new', as: 'new_subscription'
    post '/admin/subscriptions', to: 'subscription#create'
    get '/admin/subscriptions/:id', to: 'subscription#show', as: 'subscription'
    get '/admin/subscriptions/:id/edit', to: 'subscription#edit', as: 'edit_subscription'
    patch '/admin/subscriptions/:id', to: 'subscription#update'
    delete '/admin/subscriptions/:id', to: 'subscription#destroy'

    # Invoices
    get '/admin/invoices', to: 'invoice#index', as: 'invoices'
    get '/admin/invoices/new', to: 'invoice#new', as: 'new_invoice'
    post '/admin/invoices', to: 'invoice#create'
    get '/admin/invoices/:id', to: 'invoice#show', as: 'invoice'
    get '/admin/invoices/:id/edit', to: 'invoice#edit', as: 'edit_invoice'
    patch '/admin/invoices/:id', to: 'invoice#update'
    delete '/admin/invoices/:id', to: 'invoice#destroy'
    get '/admin/invoices/subscription/:subscription_id', to: 'invoice#subscription_invoices', as: 'invoices_for_subscription'
  end

  devise_for :users, skip: [:registrations], path: 'users', controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }
  authenticate :user do
    get '/user/index', to: 'user#index', as: 'user'
    get '/user/edit', to: 'devise/registration#edit', as: 'edit_user_registration'
    put 'users', to: 'devise/registrations#update', as: 'user_registration'
  end

  get '/subscription_order_received', to: 'home#subscription_order_received'
  post '/subscription_order_received', to: 'home#subscription_order_received_post'
  get '/subscription_link/:id', to: 'home#subscription_link'
  get '/api_notification', to: 'home#api_notification'
  post '/api_notification', to: 'home#api_notification_post'
  post '/home/generateInvoice', to: 'home#generateInvoice'
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
  root 'home#index', as: :unauthenticated_root
end
