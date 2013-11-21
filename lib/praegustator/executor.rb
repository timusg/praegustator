require 'praegustator'

module Praegustator
  class Executor
    def self.execute(type)
       Praegustator::Dsl.new.parse_file(Dir.pwd+"/spec/staging_recipe.rb")
    end
  end
end

