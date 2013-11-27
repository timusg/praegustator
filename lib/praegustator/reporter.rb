module Praegustator
  class Reporter

    def status
      @status
    end

    def add_spec_result node,json
      $stdout.puts "Node: #{node.ipaddress.dup.colorize(:blue)} ChefQuery: #{node.query.dup.colorize(:blue)}"
      if json[:summary][:failure_count] > 0
        @status = "failed"
        $stdout.puts "failed".colorize(:red)
      else
        $stdout.puts "passed".colorize(:green)
      end

      return if json[:examples].nil?
      $stdout.puts "  Checks:"

      json[:examples].select{|e| e[:status] =='passed'}.each do |e|
        $stdout.puts "    #{e[:full_description]}".colorize(:green)
      end

      json[:examples].select{|e| e[:status] =='failed'}.each do |e|
        $stdout.puts "    #{e[:full_description]}".colorize(:red)
      end
    end
  end
end
