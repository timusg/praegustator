require "praegustator"
module Praegustator
  class TestSuite
    attr_accessor :nodes
    def initialize(query)
      @query = query
      @checks = {}
      @nodes = Praegustator::Wrappers::Chef.search query
    end
    def check(name,opts={})
      @checks[name] = {}
      @checks[name][:opts] = opts
    end
    def execute
      # lazy load
      require 'praegustator/wrappers/server_spec'
      Praegustator::Wrappers::ServerSpec.new.execute @nodes,@checks
    end
  end
end
