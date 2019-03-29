# frozen_string_literal: true

TicketDispenser::Engine.routes.draw do
  root to: 'tickets#index'

  resources :tickets
  resources :messages
end
