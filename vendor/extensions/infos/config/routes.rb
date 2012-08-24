Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :infos do
    resources :infos, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :infos, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :infos, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
