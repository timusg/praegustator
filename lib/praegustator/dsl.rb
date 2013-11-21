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
      search("run_list:recipe\\[#{name}\\]".gsub(":","\\:"),&block)
    end

    def search(query, &block)
      query = "#{query} AND chef_environment:#{@environment}" if @environment
      suits = TestSuite.new(query)
      suits.instance_eval(&block)
      @suits << suits
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

