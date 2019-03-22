Rails.application.routes.draw do
  mount TicketingEngine::Engine => "/ticketing_engine"
end
