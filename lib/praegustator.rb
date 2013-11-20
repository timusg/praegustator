require "praegustator/version"
require 'praegustator/cli'
require 'praegustator/executor'
require 'yaml'

module Praegustator
  @config = {
    :log_level => "verbose",
    :driver => "chef"
  }

  @valid_keys = @config.keys

  def self.configure(opts = {})
    opts.each {|k,v| @config[k.to_sym] = v if @valid_keys.include? k.to_sym}
  end

  def self.configure_with(path_to_yaml_file)
    begin
      p path_to_yaml_file
      config = yaml::load(io.read(path_to_yaml_file))
    rescue errno::enoent
      p "yaml configuration file couldn't be found. using defaults."; return
    rescue psych::syntaxerror
      p "yaml configuration file contains invalid syntax. using defaults."; return
    end
    configure(config)
  end

  def self.config
    @config
  end
end
