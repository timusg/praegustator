require "thor"
require 'praegustator'

module Praegustator
  class CLI < Thor
    desc "taste", "test infrastructure"
    method_option :config_path, :aliases => "-c"
    method_option :query, :aliases => "-q"
    method_option :recipe, :aliases => "-r"
    def taste
      config_file_path = options[:config_path]
      config_file_path = File.pwd+"./.praegustator.yml" unless config_file_path

      Praegustator.configure_with config_file_path
      Praegustator::Executor.execute(options[:type])
    end


    desc "validate", "validate infrastructure  more optimized version of taste"
    method_option :config_path, :aliases => "-c"
    def validate
      config_file_path = options[:config_path]
      config_file_path = ".praegustator.yml" unless config_file_path

      Praegustator.configure_with config_file_path
      Praegustator::Executor.execute(options[:type])
    end

  end
end

