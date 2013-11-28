module Praegustator
  class Reporter

    def initialize
      @test_suite_restults = {}
    end

    def status
      @status
    end

    def add_spec_result node,json
      print_status node.ipaddress , json[:summary][:failure_count] > 0
      return if json[:examples].nil?
      @test_suite_restults[node] = json
      print_summary node.query, json[:summary]
      print_passed  json[:examples].select{|e| e[:status] =='passed'}.map{|e| e[:full_description]}
      print_failures  json[:examples].select{|e| e[:status] =='failed'}.map{|e| e[:full_description]}
    end

    private
    def print_status ipaddress , failed
      if failed
        $stdout.puts "[Failed] #{ipaddress}".colorize(:red)
      else
        $stdout.puts "[Passed] #{ipaddress}".colorize(:green)
      end
    end

    def print_summary query , summary
      return if !Praegustator.config['report']['show_summary']
      $stdout.puts ""
      $stdout.puts "  Summary:".colorize(:blue)
      $stdout.puts "    Chef Query: #{query}".colorize(:blue)
      $stdout.puts "    Duration: #{summary[:duration]}".colorize(:blue)
      $stdout.puts "    Total Checks: #{summary[:example_count]}".colorize(:blue)
      $stdout.puts "    Failed Checks: #{summary[:failure_count]}".colorize(:blue)
    end


    def print_all_summary
      duration     =      @test_suite_restults
      example_count     = @test_suite_restults
      failure_count     = @test_suite_restults
      $stdout.puts ""
      $stdout.puts "  Summary:".colorize(:blue)
      $stdout.puts "    Duration: #{duration}".colorize(:blue)
      $stdout.puts "    Total Checks: #{example_count}".colorize(:blue)
      $stdout.puts "    Failed Checks: #{failure_count}".colorize(:blue)
    end



    def print_passed specs
      return if !Praegustator.config['report']['show_passed']
      return if specs.empty?
      $stdout.puts ""
      $stdout.puts "  (#{specs.count}) Passed:".colorize(:green)
      specs.each do |spec|
        $stdout.puts "    #{spec}".colorize(:green)
      end
    end

    def print_failures specs
      return if !Praegustator.config['report']['show_failed']
      return if specs.empty?
      $stdout.puts ""
      $stdout.puts "   (#{specs.count}) Failures:".colorize(:red)
      specs.each do |spec|
        $stdout.puts "    #{spec}".colorize(:red)
      end
    end
  end
end
