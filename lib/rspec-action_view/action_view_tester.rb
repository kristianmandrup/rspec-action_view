require 'action_view'
require 'action_view/base'
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

  def set attributes={}
    attributes.each do |key, value|
      instance_var = "@#{key}"
      instance_variable_set(instance_var, value)
    end
  end

  def with_output_buffer(buf = nil)
    yield
  end  

  def with_template content=nil, &block
    require 'erb'      
    content ||= yield
    template = ERB.new content
    template.result(binding)
  end
  
  def self.tests *helpers
    helpers.flatten.each do |name|
      include name.to_s.camelize.constantize
    end
  end  
end  
