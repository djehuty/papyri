# Parameter Model Specifications
require 'papyri/models/parameter'

describe Papyri::Parameter do
  describe "#new" do
    before(:each) do
      @p = Papyri::Parameter.new "foo", "Does a foo bar", "int"
    end

    it "generates an instance with the specified name" do
      @p.name.should eql("foo")
    end
    
    it "generates an instance with the specified description" do
      @p.description.should eql("Does a foo bar")
    end

    it "generates an instance with the specified type" do
      @p.type.should eql("int")
    end

    it "generates an instance with type as nil when no type is specified" do
      p = Papyri::Parameter.new "foo", "Does a foo bar"
      p.type.should eql(nil)
    end
  end
end
