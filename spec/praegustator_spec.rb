require "spec_helper"

describe Praegustator do
  describe "config" do
  let(:config){Praegustator.config}
    it "defaults" do
      config[:log_level].should == "verbose"
      config[:driver].should == "chef"
      config[:knife_location].should == "~/.chef/knife.rb"
      config[:backend].should == "serverspec"
      config[:spec_dir].should == "spec"
    end
  end
end
