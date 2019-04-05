# frozen_string_literal: true

TicketDispenser::Engine.routes.draw do
  root to: 'tickets#index'

  resources :tickets
  get 'open_tickets' => 'tickets#open_tickets'
  put 'read_all_messages' => 'tickets#read_all_messages'
  namespace :tickets do
    resource :replies
  end
  resources :messages
end
