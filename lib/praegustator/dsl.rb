require 'praegustator'
module Praegustator
  class Dsl
    def initialize
      @suits = []
    end

    def environment(name, &block)
      @environment = name
    end

    def role(name, &block)
      search("role:#{name}",&block)
    end

    def recipe(name, &block)
      name = name.gsub(":","\\:")
      search("run_list:recipe\\[#{name}\\]",&block)
    end

    def ip(address, &block)
      search("ipaddress:#{address}",&block)
    end

    def search(query, &block)
      query = "#{query} AND chef_environment:#{@environment}" if @environment
      suite = TestSuite.new(query)
      suite.instance_eval(&block)
      @suits << suite
      suite.nodes
    end

    def parse_file(filename)
      if File.exists?(filename) && File.readable?(filename)
        self.instance_eval(IO.read(filename), filename, 1)
      else
        raise IOError, "Cannot open or read #{filename}!"
      end
      @suits
    end
  end
end
