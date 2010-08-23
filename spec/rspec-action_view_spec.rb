require 'spec_helper'

module MyViewHelper
  def tab_for(clazz, &block)               
    content = with_output_buffer(&block)  
    content_tag :li, content, :class => clazz
  end
end

module MyOtherViewHelper
  def hello(clazz, &block)               
    content = with_output_buffer(&block)
    content_tag :div, content, :class => clazz
  end
end


describe "My ViewHelpers" do
  it "should render content as expected" do        
    setup_action_view do
      tests MyViewHelper, MyOtherViewHelper      
    end

    with_action_view do |view|
      view.tab_for('kristian') { 'hello' }.should match /kristian/
      view.hello('david') { 'hello' }.should match /david/
      
      with_action_view do |view|      
        view.with_template(%{
          <%= tab_for('kristian') { 'hello' } %>
        }).should match /hello/      
        
        with_action_view do |view|      
          view.with_template do %{
            <%= tab_for('kristian') { 'hello' } %>
          }
          end.should match /hello/      
        end
      end
    end    
  end
end