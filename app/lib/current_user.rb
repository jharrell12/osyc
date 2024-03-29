require 'singleton'

# -----------------------------------------------------------
# current_user tracking
class CurrentUser
  include Singleton

  class << self
    def logged_in?
      true
    end    
  end
end