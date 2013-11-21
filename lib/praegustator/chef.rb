require 'praegustator'
require 'chef/rest'
require 'chef/search/query'

module Praegustator
  class Chef
    def self.search query
      ::Chef::Config.from_file(File.expand_path(Praegustator.config[:knife_location]))
      chef_query = ::Chef::Search::Query.new
      nodes = chef_query.search('node',query).first rescue []
      nodes.map{|n| Praegustator::Node.new n.name , n.ipaddress ,query}
    end
  end
end
