# Rspec for Rails 3 ActionView

RSpec 2 library to make it simple to spec Rails 3 ActionView extensions.
Works with locals, #html_safe and nested blocks using #with_output_buffer and much, much more...

Enjoy! I know I am... ;)

## Install

<code>gem install rspec-active_view</code>

## Usage

<pre>
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

      def my_name
        'Kristian'.html_safe
      end

      def hi(first_name_, last_name)
        "Hi #{first_name} #{last_name} !".html_safe
      end
    end
  end

  describe 'My View extensions!' do
    extend_view_with MyView, :tab, :say

    it "should work" do
      with_engine(:erb) do |e|
        e.run_template {"hello <%= my_name %>"}.should match /Kristian/

        e.run_template do 
          %{<%= tab_for :x do %>
            <%= hello :blip do %>
              ged
            <% end %>
          <% end %>}
        end.should match /ged/
      end
    end
    
    it "should assign Kristian to the local 'name' that is used in the erb" do
      with_engine(:erb) do |e|
        e.run_template_locals :first_name => 'Kristian', :last_name => 'Mandrup' do
          %{<%= hi(first_name, last_name) %>}
        end.should match /Kristian/
      end
    end
  end  
</pre>

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Kristian Mandrup. See LICENSE for details.
