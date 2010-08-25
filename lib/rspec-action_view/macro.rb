class ActionViewTester
  module Macro
    def setup_action_view &block
      ActionViewTester.instance_eval(&block)
    end    
  end
end

module RSpec::Core
  class ExampleGroup
    def with_action_view &block 
      block.call(ActionViewTester.new)
    end

    include ActionViewTester::Macro
  end
end