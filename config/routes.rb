Rails.application.routes.draw do
  # "/"にアクセスがあった時に、アクセスしてきたブラウザの設定言語からリダイレクトを判断する
  root to: "application#redirect_by_locale"
  scope "(:locale)", locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    namespace :league_of_legends, path: "lol" do
      root to: "top#index"
      resources :summoners, only: %i[ create ] do
        resources :matches, only: %i[ index show ], module: "summoners"
      end
    end
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    get "up" => "rails/health#show", as: :rails_health_check

    # Render dynamic PWA files from app/views/pwa/*
    get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
    get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

    # Defines the root path route ("/")
    # root "posts#index"
  end
end
