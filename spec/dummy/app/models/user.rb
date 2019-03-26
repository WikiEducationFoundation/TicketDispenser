# frozen_string_literal: true

class User < ApplicationRecord
  def admin?
    username == 'admin'
  end
end
