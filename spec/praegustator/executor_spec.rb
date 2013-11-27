require "spec_helper"

describe Praegustator::Executor do
  before :each do
    Praegustator::Wrappers::Chef.stub(:search)
  end

  describe "#execute" do
    it "calls execute in test suits" do
      execute_count =0
      Praegustator::TestSuite.any_instance.stub(:execute) do |arg|
        execute_count+=1
      end
      Praegustator::Executor.new.execute  [File.dirname(__FILE__)+"/resources/sample/suits/staging.rb", File.dirname(__FILE__)+"/resources/sample/suits/default.rb"]
      execute_count.should == 6
    end

  end

  describe "#execute_check" do
    it "call execute in test suite" do
      Praegustator::TestSuite.any_instance.should_receive(:execute)
      Praegustator::Executor.new.execute_check "foo","bar"
    end
  end
end
