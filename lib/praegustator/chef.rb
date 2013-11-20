require 'chef/rest'
require 'chef/search/query'
module Praegustator
  class Chef
    def search query
      Chef::Config.from_file(File.expand_path("~/.chef/knife.rb"))
      query = Chef::Search::Query.new
      nodes = query.search('node',value).first rescue []
      Query.new nodes
    end
  end
end
