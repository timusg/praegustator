require "praegustator"
module Praegustator
  class TestSuite
    attr_accessor :nodes, :checks, :params

    def initialize(query)
      @query = query
      @checks = {}
      @params = {}
      @nodes = Praegustator::Wrappers::Chef.search query
    end

    def check(name)
      @checks[name] = {}
    end

    def properties(params)
        @params = params
    end

    def execute
      # lazy load
      require 'praegustator/wrappers/server_spec'
      Praegustator::Wrappers::ServerSpec.new.execute self
    end
  end
end
