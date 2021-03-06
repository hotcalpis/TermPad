# frozen_string_literal: true

Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show] do
    collection do
      post :testlogin
    end
  end

  resources :relationships, only: %i[create destroy]

  resources :posts do
    resources :likes, only: %i[create destroy]
  end

  root 'posts#index'
end

# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#              likes_create GET    /likes/create(.:format)                                                                  likes#create
#             likes_destroy GET    /likes/destroy(.:format)                                                                 likes#destroy
#          new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
#              user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
#      destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
#         new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
#        edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
#             user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
#                           PUT    /users/password(.:format)                                                                devise/passwords#update
#                           POST   /users/password(.:format)                                                                devise/passwords#create
#  cancel_user_registration GET    /users/cancel(.:format)                                                                  devise/registrations#cancel
#     new_user_registration GET    /users/sign_up(.:format)                                                                 devise/registrations#new
#    edit_user_registration GET    /users/edit(.:format)                                                                    devise/registrations#edit
#         user_registration PATCH  /users(.:format)                                                                         devise/registrations#update
#                           PUT    /users(.:format)                                                                         devise/registrations#update
#                           DELETE /users(.:format)                                                                         devise/registrations#destroy
#                           POST   /users(.:format)                                                                         devise/registrations#create
#           testlogin_users POST   /users/testlogin(.:format)                                                               users#testlogin
#                      user GET    /users/:id(.:format)                                                                     users#show
#             relationships POST   /relationships(.:format)                                                                 relationships#create
#              relationship DELETE /relationships/:id(.:format)                                                             relationships#destroy
#                post_likes POST   /posts/:post_id/likes(.:format)                                                          likes#create
#                 post_like DELETE /posts/:post_id/likes/:id(.:format)                                                      likes#destroy
#                     posts GET    /posts(.:format)                                                                         posts#index
#                           POST   /posts(.:format)                                                                         posts#create
#                  new_post GET    /posts/new(.:format)                                                                     posts#new
#                 edit_post GET    /posts/:id/edit(.:format)                                                                posts#edit
#                      post GET    /posts/:id(.:format)                                                                     posts#show
#                           PATCH  /posts/:id(.:format)                                                                     posts#update
#                           PUT    /posts/:id(.:format)                                                                     posts#update
#                           DELETE /posts/:id(.:format)                                                                     posts#destroy
#                      root GET    /                                                                                        posts#index
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
