require 'rspec'
require 'rspec-action_view/action_view_tester'
require 'rspec-action_view/macro'

RSpec.configure do |config|
  config.extend ActionViewTester::Macro
end
