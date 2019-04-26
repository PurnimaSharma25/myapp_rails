Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  namespace :api do
  	scope module: 'v1' do
	  post "/users" => "users#create"
	  post "/users/login" => "users#login"
	  post "/users/add_friend" => "users#add_friend"
	  post "/users/remove_friend" => "users#remove_friend"
	end
  end

end
