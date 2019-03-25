class User < ApplicationRecord
  def admin?
    self.username === 'admin'
  end
end