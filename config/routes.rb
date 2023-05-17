Rails.application.routes.draw do
  # * devise_for ini berasal dari generate devise
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # ! Cara bacanya method-url-controllermethod-alias(opsional)
  # get "/blog_posts/new", to: "blog_posts#new", as: :new_blog_post
  # post "/blog_posts", to: "blog_posts#create", as: :blog_posts
  # get "/blog_posts/:id", to: "blog_posts#show", as: :blog_post
  # patch "/blog_posts/:id", to: "blog_posts#update"
  # delete "/blog_posts/:id", to: "blog_posts#destroy"
  # get "/blog_posts/:id/edit", to: "blog_posts#edit", as: :edit_blog_post
  # * as: :alias ini adalah alias untuk mempersingkat "to: "blablabla" "
  # ! Route dengan parameter :id harus di paling bawah
  # * MAGIC, cukup gunakan code di bawah untuk meringkas banyak route di atas
  resources :blog_posts do
    # TODO: Intinya Pahami kode di bawah
    resource :cover_image, only: [:destroy], module: :blog_posts
  end

  # Defines the root path route ("/")
  root 'blog_posts#index'
end
