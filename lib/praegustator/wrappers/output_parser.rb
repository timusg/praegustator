require 'praegustator'
require 'colorize'

module Praegustator
  module Wrappers
    class OutputParser
      def parse node,json
        $stdout.puts "Node: #{node.ipaddress.dup.colorize(:blue)} ChefQuery: #{node.query.dup.colorize(:blue)}"
        $stdout.puts "  Checks:"
        return if json[:examples].nil?
        json[:examples].each do |e|
          if e[:status] == 'passed'
            $stdout.puts "    #{e[:full_description]} : #{e[:status]}".colorize(:green)
          else
            $stdout.puts "    #{e[:full_description]} : #{e[:status]}".colorize(:red)
          end
        end
      end
    end
  end
end
