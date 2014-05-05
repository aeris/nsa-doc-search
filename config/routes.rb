DocSearch::Application.routes.draw do
	root 'site#index'

	resources :documents, only: %i(index show) do
		resources :pages, only: %i(show)
	end

	resources :pages, only: %i(index) do
	end
end
