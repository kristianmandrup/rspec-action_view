require 'active_support/railtie'
require 'rails3_plugin_toolbox'
require 'sugar-high/kind_of'

module RSpec
  module ActionView
    module Macro
      def extend_view_with base_name, *modules
        modules = modules.flatten 
        Rails3::PluginExtender.new do
          # extend action_view with methods from some modules
          extend_rails :view do |v|   
            if base_name.kind_of?(Module) && !modules.empty? && modules.only_kinds_of?(Symbol)
              v.extend_from_module(base_name, *modules) 
            else
              v.extend_with base_name, *modules
            end
          end
        end
      end
    end
  end
end
