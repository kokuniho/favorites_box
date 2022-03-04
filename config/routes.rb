Rails.application.routes.draw do
  
  devise_for :end_users
  root to: "homes#top"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # 
  resources :items, only:[:new, :create, :index, :show, :edit, :update, :destroy ] 
  #   resources:item_comments, only:[:create, :destroy]
  #   resource :favorites, only:[:create, :destroy]
  # end
  resources :end_users,only:[:show, :edit, :update, :index ] 
  #   resource :relationships, only:[:create, :destroy]
  #   get 'followings' => 'relationships#followings', as: 'followings'
  #   get 'followers' => 'relationships#followers', as: 'followers'
  # end
end
