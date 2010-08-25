require 'spec_helper'

module MyView
  module Tab
    def tab_for(clazz, &block)               
      content = with_output_buffer(&block)  
      content_tag :li, content, :class => clazz
    end
  end

  module Say
    def hello(clazz, &block)               
      content = with_output_buffer(&block)
      content_tag :div, content, :class => clazz
    end
    
    def name
      'Kristian'
    end
  end
end

describe 'My View extensions!' do
  extend_view_with MyView, :tab, :say
  
  it "should work" do
    with_engine(:erb) do |e|
      e.run_template("hello <%= name %>").should match /Kristian/

      e.run_template do 
        %{<%= tab_for :x do %>
          <%= hello :blip do %>
            ged
          <% end %>
        <% end %>}
      end.should match /ged/
    end
  end
end