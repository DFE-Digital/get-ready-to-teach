Rails.application.routes.draw do
  # Feedback
  get  "feedback",      to: "feedback#index",  as: "feedback"
  get  "feedback/new",  to: "feedback#new",    as: "new_feedback"
  post "feedback",      to: "feedback#create"

  # Sitemap
  get "/sitemap", to: "sitemap#index"

  mount MissionControl::Jobs::Engine, at: "/jobs"

  # Errors
  scope via: :all do
    get "/404", to: "errors#not_found"
    get "/422", to: "errors#unprocessable_entity"
    get "/429", to: "errors#too_many_requests"
    get "/500", to: "errors#internal_server_error"
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Keep this last to route any other paths to the show controller and render 404s if not found
  get "/*slug", to: "content#show"

  # Root to home page
  root to: "content#show", defaults: { slug: "home" }
end
