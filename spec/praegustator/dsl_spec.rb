require "spec_helper"

describe Praegustator::Dsl do
  describe "#parse_file" do
  let(:dsl){Praegustator::Dsl.new}
    it "should parse and load objects from file with environment defined" do
      suits = dsl.parse_file File.dirname(__FILE__)+"/resources/sample/suits/staging.rb"
      suits.count.should == 3
      first_suite = suits.first
      first_suite.instance_variable_get(:@query).should == "role:web AND chef_environment:staging"
    end

    it "should parse and load objects from file without environment" do
      suits = dsl.parse_file File.dirname(__FILE__)+"/resources/sample/suits/default.rb"
      suits.count.should == 3
      first_suite = suits.first
      first_suite.instance_variable_get(:@query).should == "role:web"
    end

    it "should create testsuits objects with checks" do
      suits = dsl.parse_file File.dirname(__FILE__)+"/resources/sample/suits/staging.rb"
      suits.count.should == 3
      first_suite = suits.first
      checks = first_suite.instance_variable_get(:@checks)
      checks.count.should == 3
    end

    it "should create testsuits objects with options provided" do
      suits = dsl.parse_file File.dirname(__FILE__)+"/resources/sample/suits/staging.rb"
      suits.count.should == 3
      first_suite = suits.first
      checks = first_suite.instance_variable_get(:@checks)
      checks["nginx"].should_not nil
      checks["puma"][:opts][:target].should == "10.210.10.1"
    end
  end
end
