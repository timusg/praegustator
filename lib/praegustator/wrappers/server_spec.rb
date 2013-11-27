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
        suite.nodes.each do |n|
          ENV['TARGET_HOST'] = n.ipaddress
          formatter = RSpec::Core::Formatters::JsonFormatter.new(nil)
          RSpec.clear_remaining_example_groups
          load 'serverspec.rb'
          begin
            params = suite.params
            params[:current_node] = n
            RSpec.configure do |c|
              c.host  = ENV['TARGET_HOST']
              options = Net::SSH::Config.for(c.host)
              user    = options[:user] || Praegustator.config['ssh']['user']
              options[:keys] = Praegustator.config['ssh']['keys'] if options[:keys].nil?
              options[:timeout] = 10
              c.ssh   = Net::SSH.start(c.host, user, options)
              c.os    = backend.check_os
              set_property params
              c.output = $stdout
              c.color_enabled = true
              c.tty = true
              if Praegustator.config['log_level'] == 'debug'
                formatter = RSpec::Core::Formatters::DocumentationFormatter.new(c.output)
              end
              reporter =  RSpec::Core::Reporter.new(formatter)
              c.instance_variable_set(:@reporter, reporter)
            end
            spec_files = suite.checks.keys.map{|check| "#{Dir.pwd}/#{Praegustator.config['spec']['checks_dir']}/#{check}.rb" }
            begin
              RSpec::Core::Runner.run_patched(spec_files, $stderr, $stdout)
            rescue Exception => e
              $stderr.puts "!! spec execution failed #{e.message}"
            end
            if Praegustator.config['log_level'] != 'debug'
              @parser.parse n,formatter.output_hash
            end
          rescue Exception => e
            $stderr.puts e.backtrace.join("\n")
            $stderr.puts "!! failed for #{n.ipaddress} : #{e.message}"
          end
        end
      end
    end
  end
end
