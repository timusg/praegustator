require "praegustator/version"
require 'praegustator/cli'
require 'praegustator/executor'
require 'praegustator/dsl'
require 'yaml'

module Praegustator
  @config = {
    :log_level => "verbose",
    :driver => "chef",
    :knife_location =>  ENV['KNIFE_PATH'] || "~/.chef/knife.rb",
    :backend => "serverspec",
    :spec_dir => "spec"
  }


  def self.configure_with(path_to_yaml_file)
    begin
      p path_to_yaml_file
      config = yaml::load(io.read(path_to_yaml_file))
    rescue Exception
      p "yaml configuration file couldn't be found. using defaults."; return
    end
    configure(config)
  end

  def self.config
    @config
  end

  private
  def self.configure(opts = {})
    valid_keys = @config.keys
    opts.each {|k,v| @config[k.to_sym] = v if valid_keys.include? k.to_sym}
  end
end
