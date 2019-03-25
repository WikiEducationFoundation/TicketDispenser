Rails.application.routes.draw do
  mount TicketDispenser::Engine => "/ticketing_engine"
end
