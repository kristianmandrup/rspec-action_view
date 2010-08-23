# require 'active_support'
require 'action_view'
require 'active_support/railtie'
require 'action_view/template/handlers/erb'

class ActionViewTester
  include ActionView::Helpers::TagHelper  
  include ActionView::Helpers::CaptureHelper

  def initialize &block
    if block
      block.arity < 1 ? self.instance_eval(&block) : block.call(self)  
    end    
  end

  def with_output_buffer(buf = nil)
    yield
  end  
  
  def self.tests *helpers
    helpers.flatten.each do |name|
      include name.to_s.camelize.constantize
    end
  end  
end  

module RSpec::Core
  class ExampleGroup
    def with_action_view &block 
      block.call(ActionViewTester.new)
    end
    
    def setup_action_view &block
      ActionViewTester.instance_eval(&block)
    end
  end
end