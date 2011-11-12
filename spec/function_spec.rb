# Function Model Specifications
require 'papyri/models/function'

describe Papyri::Function do
  describe "#new" do
    before(:each) do
      @f = Papyri::Function.new "foobar", "Does a foo bar", [
        {"name"=>"a", "description"=>"does a thing"},
        {"name"=>"b", "description"=>"does something else"}
      ]
    end

    it "generates an instance with the specified name" do
      @f.name.should eql("foobar")
    end

    it "generates an instance with the specified description" do
      @f.description.should eql("Does a foo bar")
    end

    it "generates instances of Parameter equal to the number of parameters passed" do
      @f.parameters.length.should eql(2)
    end

    it "generates an instance with the parameters as an empty array if none are specified" do
      f = Papyri::Function.new "foobar", "Does a foo bar"
      f.parameters.should eql([])
    end

    it "generates an instance with no parameters if an empty array is specified" do
      f = Papyri::Function.new "foobar", "Does a foo bar", []
      f.parameters.should eql([])
    end
  end
end
