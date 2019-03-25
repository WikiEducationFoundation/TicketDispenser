Rails.application.routes.draw do
  mount TicketDispenser::Engine => "/tickets"
end
