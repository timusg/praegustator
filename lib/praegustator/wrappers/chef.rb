require 'praegustator'
require 'chef/rest'
require 'chef/search/query'

module Praegustator
  module Wrappers
    class Chef
      def self.search query
        ::Chef::Config.from_file(File.expand_path(Praegustator.config['chef']['knife_location']))
        chef_query = ::Chef::Search::Query.new
        nodes = chef_query.search('node',query).first rescue []
        $stdout.puts "no node found for search criteria: #{query}" if nodes.empty?
        nodes.map{|n| Praegustator::Node.new n.name , n.ipaddress ,query}
      end
    end
  end
end
