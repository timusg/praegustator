require "spec_helper"

describe Praegustator do
  describe ".config" do
    subject(:config){Praegustator.config}
    it "returnlog level" do
      config['log_level'].should == 'info'
    end

    it "return knife_location" do
      config['chef']['knife_location'].should == '~/.chef/knife.rb'
    end

    it "return search driver" do
      config['search_driver'].should == 'chef'
    end

    it "return backend" do
      config['spec']['backend'].should == 'serverspec'
    end

    it "return checks dir" do
      config['spec']['checks_dir'].should == 'spec/shared'
    end
  end

  describe ".configure_with" do
    before :each do
     Praegustator.configure_with File.dirname(__FILE__)+"/praegustator/resources/sample/config/praegustator.yml"
    end
    subject(:config){Praegustator.config}
    it "sets log level" do
      config['log_level'].should == 'info'
    end

    it "sets knife_location" do
      config['chef']['knife_location'].should == '.zero-knife.rb'
    end

    it "sets search driver" do
      config['search_driver'].should == 'chef'
    end

    it "sets recipie dir" do
      config['spec']['recipes_dir'].should == 'recipies/'
    end

    it "sets checks dir" do
      config['spec']['checks_dir'].should == 'recipies/checks/'
    end

  end

end
