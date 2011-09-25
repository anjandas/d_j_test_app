DelayedJobSample::Application.routes.draw do
  
  resources :jobs  do
    member do
      post 'perform_inline'
      post 'perform_old_way'
      post 'perform_as_low_importance_with_delay'
      post 'perform_as_normal_importance_with_delay'
      post 'perform_as_high_importance_with_delay'
      post 'perform_examplejob_with_normal_importance'
      post 'perform_examplejob_with_high_importance'
      post 'perform_examplejob_with_low_importance'
    end
  end

  root :to => 'jobs#index'

end
