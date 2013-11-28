require "spec_helper"

describe Praegustator::CLI do
  describe "#taste" do
    it "execute_check from executor" do
      Praegustator::Executor.any_instance.should_receive(:execute_check)
      Praegustator::CLI.new.taste("foo","bar")
    end
  end

  describe "#validate" do
    it "execute from executor" do
      Praegustator::Executor.any_instance.should_receive(:execute)
      Praegustator::CLI.new.validate("foo","bar")
    end
  end

  describe "#init" do
    it "sets knife_location" do
      Praegustator::Setup.any_instance.should_receive(:init).with("foo")
      Praegustator::CLI.new.init("foo")
    end
  end
end
