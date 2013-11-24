require "thor"
require 'praegustator'

module Praegustator
  class CLI < Thor

    desc "taste", "test an check against a chef query"
    long_desc <<-LONGDESC
    `praeg taste query check` will execute check against node returned by query
    > $ praeg taste role:web nginx
    LONGDESC
    def taste(query,check)
      config_file_path = Dir.pwd+"/.praegustator.yml"
      Praegustator.configure_with config_file_path
      recipes_dir = Praegustator.config['spec']['recipes_dir']
      recipes = Dir[Dir.pwd+"/#{recipes_dir}/**/*_recipe.rb"] if recipes.empty?
      Praegustator::Executor.new.execute(recipes)
    end

    desc "validate", "validate infrastructure by executing checks defined in recipe files"
    def validate(*recipes)
      config_file_path = Dir.pwd+"/.praegustator.yml"
      Praegustator.configure_with config_file_path
      recipes_dir = Praegustator.config['spec']['recipes_dir']
      recipes = Dir[Dir.pwd+"/#{recipes_dir}/**/*_recipe.rb"] if recipes.empty?
      Praegustator::Executor.new.execute(recipes)
    end
    desc "init" , "setup praegustator"
    long_desc " > $ praeg setup spec_dir"
    def init(spec_dir ='spec')
      Praegustator::Setup.new.init(spec_dir)
    end
  end
end

