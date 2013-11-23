require "praegustator"
module Praegustator
  class TestSuite
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
      Praegustator::Wrappers::ServerSpec.new.execute @nodes,@checks
    end
  end
end
