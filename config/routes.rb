DocSearch::Application.routes.draw do
	root 'site#index'
	post '/', to: 'site#search'

	resources :documents, only: %i(show) do
		resources :pages, only: %i(show)
	end
end
