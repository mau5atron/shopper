Rails.application.routes.draw do
	root to: 'categories#index'
	resources :categories, only: [:index] do 
		resources :products, only: [:index]
	end
end
