require "spec_helper"

describe Praegustator::CLI do
  describe "#taste" do
    before do
      Praegustator::Executor.any_instance.stub(:execute_check).and_return('foo')
    end
    subject { Praegustator::CLI.new.taste("foo","bar")}
    it { should eq 'foo' }
  end

  describe "#validate" do
    before do
      Praegustator::Executor.any_instance.stub(:execute).and_return(1)
    end
    subject { Praegustator::CLI.new.validate("foo") }
    it { should eq 1 }
  end

  describe "#init" do
    it "sets knife_location" do
      Praegustator::Setup.any_instance.should_receive(:init).with("foo")
      Praegustator::CLI.new.init("foo")
    end
  end
end
