# Class Model Specifications
require 'papyri/models/class'

describe Papyri::Class do
  describe "#new" do
    before(:each) do
      @cls = Papyri::Class.new("test/stream.yaml")
    end

    it "reads the class name from the yaml file" do
      @cls.name.should eql("Stream")
    end

    it "reads the module name from the yaml file" do
      @cls.module.should eql("io.stream")
    end

    it "reads the constructors from the yaml file" do
      @cls.constructors.length.should eql(2)
      @cls.constructors[0].description.should eql("This constructor will create a stream attached to predefined functions.")
      @cls.constructors[1].description.should eql("This constructor will create an unattached stream.")
    end

    it "reads the events from the yaml file" do
      @cls.events.length.should eql(1)
      @cls.events[0].description.should eql("This event is triggered when the read method is called on this stream without a supplied buffer.")
    end

    it "reads the methods from the yaml file" do
      @cls.methods.length.should eql(2)
      @cls.methods[0].description.should eql("This function appends the given data...")
      @cls.methods[1].description.should eql("This function will read a number of bytes from the stream at the current position. These bytes will be returned by a buffer supplied by the stream. It will be a shallow copy whenever possible.")
    end

    it "reads the properties from the yaml file" do
      @cls.properties.length.should eql(3)
      @cls.properties[0].name.should eql("length")
      @cls.properties[1].name.should eql("available")
      @cls.properties[2].name.should eql("position")
    end
  end
end