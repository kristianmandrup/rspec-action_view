require 'rspec'
require 'require_all'

require_all File.dirname(__FILE__) + '/rspec-action_view'

RSpec.configure do |config|
  config.extend RSpec::ActionView::Macro
end
