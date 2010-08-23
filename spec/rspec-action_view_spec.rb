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
        view.set :posts => ['post 1', 'post 2'], :title => 'Blog posts index'
        view.instance_variable_get('@posts').should have(2).items
        
        res = view.with_template do %{
          <%= @title %>
          <%= tab_for('kristian') { 'hello' } %>
          <%= @posts.join(',') %>
        }
        end
        res.should match /hello/
        res.should match /Blog posts index/
        res.should match /post 1/        
        
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