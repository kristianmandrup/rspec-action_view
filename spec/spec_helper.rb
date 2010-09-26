require 'rspec/core'
require 'rspec-action_view'

# module Minimal
#   class Application < Rails::Application
#     config.active_support.deprecation = :log
#   end
# end
# 
# Rails.application = Minimal::Application

RSpec.configure do |config|
  config.mock_with :mocha
end