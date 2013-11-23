require "thor"
require 'praegustator'

module Praegustator
  class CLI < Thor
    desc "taste", "test infrastructure"
    method_option :query, :aliases => "-q"
    method_option :recipe, :aliases => "-r"
    def taste(*recipes)
      recipes = Dir[Dir.pwd+"/spec/**/*_recipe.rb"] if recipes.empty?
      config_file_path = Dir.pwd+"/.praegustator.yml"
      Praegustator.configure_with config_file_path
      p recipes
      Praegustator::Executor.execute(recipes)
    end


    desc "validate", "validate infrastructure  more optimized version of taste"
    def validate
      config_file_path = Dir.pwd+"/.praegustator.yml"
      Praegustator.configure_with config_file_path
      Praegustator::Executor.execute()
    end

  end
end

