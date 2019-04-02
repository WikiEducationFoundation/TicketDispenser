# frozen_string_literal: true

TicketDispenser::Engine.routes.draw do
  root to: 'tickets#index'

  resources :tickets
  get 'open_tickets' => 'tickets#open_tickets'
  resources :messages
end
