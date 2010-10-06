module RSpec::Core
  class ExampleGroup
    def view_engine type = :erb, &block 
      engine = RSpec::ActionView::ERBTemplateEngine.new
      
      if block
        block.arity < 1 ? engine.instance_eval(&block) : block.call(engine, engine.view)
      end
    end      

    def with_action_view type = :erb, &block 
      engine = RSpec::ActionView::ERBTemplateEngine.new
      
      if block
        block.arity < 1 ? engine.view.instance_eval(&block) : block.call(engine.view)
      end
    end      
  end
end