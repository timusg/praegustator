require "thor"
require 'praegustator'

module Praegustator
  class CLI < Thor
    desc "taste", "test infrastructure"
    method_option :query, :aliases => "-q"
    method_option :recipe, :aliases => "-r"
    def taste(*recipes)
      config_file_path = Dir.pwd+"/.praegustator.yml"
      Praegustator.configure_with config_file_path
      p Praegustator.config
      recipes_dir = Praegustator.config['spec']['recipes_dir']
      recipes = Dir[Dir.pwd+"/#{recipes_dir}/**/*_recipe.rb"] if recipes.empty?
      Praegustator::Executor.execute(recipes)
    end
    desc "validate", "validate infrastructure  more optimized version of taste"
    def validate
      config_file_path = Dir.pwd+"/.praegustator.yml"
      Praegustator.configure_with config_file_path
      Praegustator::Executor.execute()
    end
    desc "init" , "setup praegustator"
    def init(spec_dir)
      Praegustator::Setup.init(spec_dir)
    end
  end
end

