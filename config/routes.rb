Rails.application.routes.draw do
  root to: 'leads#index'

  devise_for :admins

  resources :leads
  get '/next' => 'leads#next'
  get '/no_leads' => 'leads#no_leads'
  get '/token' => 'leads#token'
  post '/voice' => 'leads#voice'
  post '/text' => 'leads#text'
  post '/auto_text' => 'leads#auto_text'

  get '/daily_logs' => 'daily_progress_logs#index'

  post '/incoming_voice' => 'webhooks#incoming_voice'
  post '/incoming_text' => 'webhooks#incoming_text'

  get '/settings/edit' => 'settings#edit'
  patch '/settings' => 'settings#update'

  namespace :api do
    namespace :v1 do
      get '/leads' => 'leads#index'
      get '/leads/:id' => 'leads#show'
      post '/leads' => 'leads#create'
    end
  end

end
