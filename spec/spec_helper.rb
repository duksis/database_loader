$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include?(File.dirname(__FILE__))

require 'active_support/core_ext'

class Rails
  def self.root
    File.expand_path('support',File.dirname(__FILE__))
  end
end

require 'database_loader'
