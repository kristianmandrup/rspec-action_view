require 'action_view'
require 'action_view/context'

module RSpec
  module ActionView
    class ERBTemplateEngine

      ERBHandler = ::ActionView::Template::Handlers::ERB

      attr_accessor :output_buffer, :rendered

      def initialize
        @output_buffer = ActiveSupport::SafeBuffer.new
        @rendered = ''
      end

      def render(options = {}, local_assigns = {}, &block)
        view.assign(_assigns)
        output = view.render(options, local_assigns, &block)
        @rendered << output
        output
      end

      module Locals
        attr_accessor :locals
      end

      def locals
        @locals ||= {}
      end

      def _get_view
        view = ::ActionView::Base.new                                  
      
        # ???
        # view.singleton_class.send :include, _helpers

        view.extend(Locals)
        view.locals = self.locals
        view.output_buffer = self.output_buffer
        view
      end

      def view
        @view ||= _get_view
      end

      alias_method :_view, :view
  
      EXCLUDE_IVARS = %w{
        @_assertion_wrapped
        @_result
        @controller
        @layouts
        @locals
        @method_name
        @output_buffer
        @partials
        @rendered
        @request
        @routes
        @templates
        @test_passed
        @view
        @view_context_class
      }

      def _instance_variables
        instance_variables.map(&:to_s) - EXCLUDE_IVARS
      end

      def _assigns
        _instance_variables.inject({}) do |hash, var|
          name = var[1..-1].to_sym
          hash[name] = instance_variable_get(var)
          hash
        end
      end  

      def run_template_locals locals = {}, local_assigns = {}, &block
        raise ArgumentError, "Must take template as a block argument" if !block
        options = {:inline => block.call}
        render options.merge(:locals => locals), {}
      end

      def run_template options = {}, local_assigns = {}, &block
        raise ArgumentError, "Must take template as a block argument" if !block        
        render options.merge(:inline => block.call), local_assigns
      end
    end  
  end
end



