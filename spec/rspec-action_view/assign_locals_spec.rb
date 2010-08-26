require 'spec_helper'

module MyView
  
  def goodbye name
    "Goodbye #{name}".html_safe
  end

  def hello name
    "Hello #{name}".html_safe
  end
  
  module Tab
    def tab_for(clazz, &block)               
      content = with_output_buffer(&block)  
      content_tag :li, content, :class => clazz
    end
  end    
end

describe 'My View extensions!' do
  extend_view_with MyView

  describe '#run_template' do  
    it "should assign Kristian to the local 'name' that is used in the erb" do
      with_engine(:erb) do |e|
        e.run_template(:locals => {:name => 'Kristian'}) {"<%= goodbye name %>"}.should match /Kristian/
      end
    end
  end

  describe '#run_template_locals' do
    it "should assign Kristian to the local 'name' that is used in the erb" do
      with_engine(:erb) do |e|
        e.run_template_locals :name => 'Kristian' do
          %{<%= goodbye name %>}
        end.should match /Kristian/
      end
    end
  end
end