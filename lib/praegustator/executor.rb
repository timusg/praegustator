require 'praegustator'

module Praegustator
  class Executor
    def self.execute(recipes)
       recipes.each do |recipe|
       suits = Praegustator::Dsl.new.parse_file(recipe)
       suits.each(&:execute)
       end
    end
  end
end

