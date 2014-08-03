Rails.application.routes.draw do
  get 'demo/index'
  get 'demo/show' => 'demo#show'

  post 'create_avatar' => 'image_upload#create_avatar'
  put 'update_avatar' => 'image_upload#update_avatar'

  root 'demo#index'
end
