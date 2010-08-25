require 'active_support/railtie'
require 'rails3_plugin_toolbox'

module RSpec
  module ActionView
    module Macro
      def extend_view_with_modules *modules
        Rails3::PluginExtender.new do
          # extend action_view with methods from some modules
          extend_rails :view do                 
            extend_with *modules
          end    
        end
      end

      def extend_view_with base_name, *modules 
        Rails3::PluginExtender.new do
          # extend action_view with methods from some modules
          extend_rails :view do
            extend_from_module base_name, *modules 
          end    
        end
      end
    end
  end
end
