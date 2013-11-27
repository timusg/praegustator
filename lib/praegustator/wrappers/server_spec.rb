require 'praegustator'
require 'praegustator/wrappers/output_parser'
require 'net/ssh'
require 'serverspec'
require 'rspec/core/formatters/json_formatter'
require 'rspec/core/formatters/documentation_formatter'

include Serverspec::Helper::Ssh
include Serverspec::Helper::DetectOS

module Praegustator
  module Wrappers
    class ServerSpec

      def initialize
        @parser = Praegustator::Wrappers::OutputParser.new
      end

      def execute suite
        suite.nodes.each do |node|
          ENV['TARGET_HOST'] = node.ipaddress
          spec_files = suite.checks.keys.map{|check| "#{Dir.pwd}/#{Praegustator.config['spec']['checks_dir']}/#{check}.rb" }
          run_rspec suite, node, spec_files
        end
      end

      private
      def run_rspec  suite, node, spec_files
        formatter = RSpec::Core::Formatters::JsonFormatter.new(nil)
        RSpec.clear_remaining_example_groups
        load 'serverspec.rb'
        begin
          params = suite.params
          params[:current_node] = node
          RSpec.configure do |config|
            config.host  = ENV['TARGET_HOST']
            options = Net::SSH::Config.for(config.host)
            user    = options[:user] || Praegustator.config['ssh']['user']
            options[:keys] = Praegustator.config['ssh']['keys'] if options[:keys].nil?
            options[:timeout] = 10
            config.ssh   = Net::SSH.start(config.host, user, options)
            config.os    = backend.check_os
            set_property params
            config.output = $stdout
            config.color_enabled = true
            config.tty = true
            if Praegustator.config['log_level'] == 'debug'
              formatter = RSpec::Core::Formatters::DocumentationFormatter.new(config.output)
            end
            reporter =  RSpec::Core::Reporter.new(formatter)
            config.instance_variable_set(:@reporter, reporter)
          end
          begin
            RSpec::Core::Runner.run_patched(spec_files, $stderr, $stdout)
          rescue Exception => e
            $stderr.puts e.backtrace.join("\n")
            $stderr.puts "!! spec execution failed #{e.message}"
          end
          if Praegustator.config['log_level'] != 'debug'
            @parser.parse node,formatter.output_hash
          end
        rescue Exception => e
          $stderr.puts e.backtrace.join("\n")
          $stderr.puts "!! failed for #{node.ipaddress} : #{e.message}"
        end
      end

    end
  end
end
