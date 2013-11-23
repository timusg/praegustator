require 'praegustator'
require 'net/ssh'
require 'serverspec'
require 'rspec/core/formatters/json_formatter'
require 'rspec/core/formatters/documentation_formatter'
include Serverspec::Helper::Ssh
include Serverspec::Helper::DetectOS

module Praegustator
  module Wrappers
    class ServerSpec
      def execute nodes,checks
        nodes.each do |n|
          p "executing test for #{n.ipaddress}"
          ENV['TARGET_HOST'] = n.ipaddress
          load 'serverspec.rb'
          RSpec.configure do |c|
            c.host  = ENV['TARGET_HOST']
            options = Net::SSH::Config.for(c.host)
            user    = "root"
            options[:keys] = Praegustator.config[:ssh]["keys"] if options[:keys].nil?
            options[:timeout] = 10
            begin
              c.ssh   = Net::SSH.start(c.host, user, options)
            rescue Exception => e
              p e
              break
            end
            c.os    = backend.check_os
            c.output = $stdout
            p "running spec for #{c.host}"
            c.color_enabled = true
            c.tty = true
            documentation_formatter = RSpec::Core::Formatters::DocumentationFormatter.new(c.output)
            reporter =  RSpec::Core::Reporter.new(documentation_formatter)
            c.instance_variable_set(:@reporter, reporter)
          end
          spec_files = checks.keys.map{|check| "#{Dir.pwd}/#{Praegustator.config[:checks_dir]}/#{check}.rb" }
          RSpec::Core::Runner.run_patched(spec_files, $stderr, $stdout)
          RSpec.reset
        end
      end
    end
  end
end
