require "praegustator/version"
require 'praegustator/cli'
require 'praegustator/executor'
require 'praegustator/test_suite'
require 'praegustator/dsl'
require 'praegustator/wrappers/chef'
require 'praegustator/node'
require 'praegustator/setup'
require 'yaml'
require 'colorize'

module Praegustator
  @config = {
    'log_level' => 'info',
    'search_driver' => 'chef',
    'chef' => {
      'knife_location' =>  ENV['KNIFE_PATH'] || "~/.chef/knife.rb"
    },
    'spec' => {
      'backend' => 'serverspec',
      'recipes_dir' =>  'spec/',
      'checks_dir' => 'spec/shared',
    },
    'ssh' => {
      'user' => 'root',
      'pasword' => nil,
      'keys' => []
    }
  }

  def self.configure_with(path_to_yaml_file)
    begin
      config = YAML::load(IO.read(path_to_yaml_file))
    rescue Psych::SyntaxError
      p  "error while parsing yaml configuration file. using defaults."; return
    rescue Exception
      p  "yaml configuration file couldn't be found. using defaults."; return
    end
    configure(config)  if config
  end

  def self.config
    @config
  end

  private
  def self.configure(opts = {})
    valid_keys = @config.keys
    opts.each {|k,v| @config[k] = v if valid_keys.include? k}
  end
end


module RSpec
  module Core
    class Runner
      def self.run_patched(args, err=$stderr, out=$stdout)
        trap_interrupt
        options = ConfigurationOptions.new(args)
        options.parse_options

        if options.options[:drb]
          require 'rspec/core/drb_command_line'
          begin
            DRbCommandLine.new(options).run(err, out)
          rescue DRb::DRbConnError
            CommandLine.new(options).run(err, out)
          end
        else
          CommandLine.new(options).run(err, out)
        end
      ensure
        #RSpec.reset
      end
    end
  end
end
