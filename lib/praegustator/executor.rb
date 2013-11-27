require 'praegustator'

module Praegustator
  class Executor
    def initialize
    end
    def execute(recipes)
      recipes.each do |recipe|
        suits = Praegustator::Dsl.new.parse_file(recipe)
        suits.each(&:execute)
      end
    end
    def execute_check(query,check)
      suite = Praegustator::TestSuite.new(query)
      suite.check check
      suite.execute
    end
  end
end
