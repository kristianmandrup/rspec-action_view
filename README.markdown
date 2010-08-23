# Rspec for Rails 3 ActionView

RSpec 2 library to make it simple to spec Rails 3 ActionView extensions  

## Install

<code>gem install rspec-active_view</code>

## Usage

<pre>
  describe "My ViewHelpers" do
    it "should render content as expected" do        
      setup_action_view do
        tests MyViewHelper, MyOtherViewHelper      
      end

      with_action_view do |view|
        view.tab_for('kristian') { 'hello' }.should match /kristian/
        view.hello('david') { 'hello' }.should match /david/
      end   
      
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
