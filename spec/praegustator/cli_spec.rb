require "spec_helper"

describe Praegustator::CLI do
  describe "#taste" do
  end

  describe "#validate" do
    before do
      Praegustator::Executor.any_instance.stub(:execute).and_return('foo')
    end
    subject { Praegustator::CLI.new.validate("foo") }
    it { should eq 'foo' }
  end

  describe "#init" do
    describe "#init" do
      it "sets knife_location" do
        Praegustator::Setup.any_instance.should_receive(:init).with("foo")
        Praegustator::CLI.new.init("foo")
      end
    end
  end
end
