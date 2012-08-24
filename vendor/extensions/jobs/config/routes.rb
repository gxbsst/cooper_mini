Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :jobs do
    resources :jobs, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :jobs, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :jobs, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
