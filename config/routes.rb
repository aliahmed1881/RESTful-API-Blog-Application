Rails.application.routes.draw do
 scope :api, defaults: { format: :json } do
 
  	devise_for :users, controllers: { sessions: :sessions }, path_names: { sign_in: :login }

    resource :users, only: [:show, :update] do
    	resources :posts, only: [:index,:create,:show,:update, :destroy] do
    		resources :comments, only: [:index,:create,:show,:update, :destroy]
    	end
    end

  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
