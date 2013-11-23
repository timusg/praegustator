module Praegustator
  class Node
    attr_accessor :ipaddress, :name, :query
    def initialize name,ipaddress,query
      @name = name
      @ipaddress =ipaddress
      @query = query
    end
  end
end
