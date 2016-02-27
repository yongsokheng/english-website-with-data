Rails.application.routes.draw do
  root "static_pages#index"
  mount Ckeditor::Engine => "/ckeditor"
  namespace :admin do
    root to: "dashboards#index"
    resources :articles, except: [:show]
    resources :categories, except: [:show]
    resources :dashboards, only: [:index]
    resources :notifications, only: [:index, :new, :create, :destroy]
    resources :passwords, only: [:edit, :update]
    resources :profiles, only: [:show, :edit, :update]
    resources :users, except: [:show]
    resources :trashes, only: [:index, :edit, :destroy]
  end

  resources :articles, only: [:show]
  resources :categories, only: [:index, :show]

  get "popular" => "categories#index"
  get "device" => "static_pages#device"
  get "test" => "static_pages#google"
  get "test3" => "static_pages#google3"
  get "test2" => "static_pages#google2"
  get "article_banner" => "static_pages#article_banner"
  get "right_banner" => "static_pages#right_banner"
  get "advertising" => "static_pages#advertising"

  devise_for :users
end
