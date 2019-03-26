# frozen_string_literal: true

Rails.application.routes.draw do
  mount TicketDispenser::Engine => '/tickets'
end
