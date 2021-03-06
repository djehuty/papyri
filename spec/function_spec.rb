# Function Model Specifications
require 'papyri/models/function'

describe Papyri::Function do
  describe "#new" do
    before(:each) do
      @f = Papyri::Function.new "foobar", "Does a foo bar", {"description" => "Returns a thing", "type" => "int"}, [
        {"name"=>"a", "description"=>"does a thing"},
        {"name"=>"b", "description"=>"does something else"}
      ]
    end

    it "generates an instance with a null return parameter if no description is given" do
      f = Papyri::Function.new "foobar", "Does a foo bar", {"foo"=>"eh"}, [
        {"name"=>"a", "description"=>"does a thing"},
        {"name"=>"b", "description"=>"does something else"}
      ]

      f.returns.should eql(nil)
    end

    it "generates an instance with a null return parameter if nil is passed" do
      f = Papyri::Function.new "foobar", "Does a foo bar", nil, [
        {"name"=>"a", "description"=>"does a thing"},
        {"name"=>"b", "description"=>"does something else"}
      ]

      f.returns.should eql(nil)
    end

    it "generates an instance with the specified return description" do
      @f.returns.description.should eql("Returns a thing")
    end

    it "generates an instance with the specified return type" do
      @f.returns.type.should eql("int")
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
      f = Papyri::Function.new "foobar", "Does a foo bar", {}
      f.parameters.should eql([])
    end

    it "generates an instance with no parameters if an empty array is specified" do
      f = Papyri::Function.new "foobar", "Does a foo bar", {}, []
      f.parameters.should eql([])
    end
  end
end
