require "thor"
require 'praegustator'

module Praegustator
  class CLI < Thor
    desc "taste", "test infrastructure"
    method_option :instance_type, :aliases => "-t"
    method_option :config_path, :aliases => "-c"
    def taste 
      config_file_path = options[:config_path]
      config_file_path = ".praegustator" unless config_file_path

      Praegustator.configure_with config_file_path
      Praegustator::Executor.execute(options[:type])
    end
  end
end

