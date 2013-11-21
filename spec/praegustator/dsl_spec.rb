require "spec_helper"

describe Praegustator::Dsl do
  describe "#parse_file" do
  let(:dsl){Praegustator::Dsl.new}
    it "should parse and load objects from file" do
      dsl.parse_file File.dirname(__FILE__)+"/resources/sample/suits/staging.rb"
    end
  end
end
