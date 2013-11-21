require 'praegustator'
module Praegustator
  class TestSuite
    def initialize(query)
      @query = query
      @checks = {}
    end

    def check(name,opts={})
      @checks[name] = {}
      @checks[name][:opts] = opts
    end
  end
end

