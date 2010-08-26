require 'spec_helper'

module MyView
  
  def goodbye
    'Goodbye'
  end
  
  module Tab
    def tab_for(clazz, &block)               
      content = with_output_buffer(&block)  
      content_tag :li, content, :class => clazz
    end
  end

  module Blip
    def blip
      content_tag :li, 'blip me'
    end
  end

  module Blap
    def blap
      content_tag :li, 'blap me'
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
  extend_view_with MyView
  extend_view_with MyView::Blap, 'MyView::Blip'
  
  it "should extend with single module MyView" do
    with_engine(:erb) do |e|
      e.run_template {"<%= goodbye %>"}.should match /Goodbye/
    end
  end


  it "should extend with module Say - hello, name" do
    with_engine(:erb) do |e|
      e.run_template {"hello <%= name %>"}.should match /Kristian/
  
      e.run_template do 
        %{
          <%= hello :blip do %>
            ged
          <% end %>
        }
      end.should match /ged/
    end
  end

  it "should extend with modules Blip and Blap" do
    with_engine(:erb) do |e|
      e.run_template {"hello <%= blip %> go <%= blap %>"}.should match /blip me/
    end
  end

  it "should extend handle nested blocks in ERB" do
    with_engine(:erb) do |e|
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