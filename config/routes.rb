Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'
  # 7つのアクションindex,new,create等をonly: []に記述して
  # いたが全てのアクションを記載した場合は不要のため削除
  resources :tweets do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :users, only: :show
end
