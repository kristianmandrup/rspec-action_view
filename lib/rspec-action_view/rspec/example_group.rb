module RSpec::Core
  class ExampleGroup
    def with_engine type = :erb, &block 
      engine = RSpec::ActionView::ERBTemplateEngine.new
      
      if block
        block.arity < 1 ? engine.instance_eval(&block) : block.call(engine, engine.view)
      end
    end      
    
    # include RSpec::ActionView::Macro
  end
end