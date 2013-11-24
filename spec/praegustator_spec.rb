require "spec_helper"

describe Praegustator do
  describe ".config" do
    let(:config){Praegustator.config}
    it "defaults" do
      config['log_level'].should == 'info'
      config['search_driver'].should == 'chef'
      config['chef']['knife_location'].should == '~/.chef/knife.rb'
      config['spec']['backend'].should == 'serverspec'
      config['spec']['checks_dir'].should == 'spec/shared'
    end
  end
end
