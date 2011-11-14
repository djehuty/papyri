# Module Model Specifications

require 'papyri/models/module'
require 'papyri/models/class'

describe Papyri::Module do
  before(:each) do
    classes = []
    @model_a = Papyri::Class.new("test/stream.yaml")
    classes << {:model => @model_a, 
      :filename => "stream.html"}
    @model_b = Papyri::Class.new("test/foo.yaml")
    classes << {:model => @model_b,
      :filename => "foo.html"}

    @module = Papyri::Module.new "io", classes
  end

  describe "#new" do
    it "generates an instance with the given name" do
      @module.name.should eql("io")
    end
  end

  describe "#classes" do
    it "should give the list of all models" do
      classes = @module.classes
      classes.include?(@model_a).should eql(true)
      classes.include?(@model_b).should eql(true)
      classes.length.should eql(2)
    end
  end
  
  describe "#files" do
    it "should give the list of all filenames" do
      files = @module.files
      files.include?("foo.html").should eql(true)
      files.include?("stream.html").should eql(true)
      files.length.should eql(2)
    end
  end

  describe "#filename_for_class" do
    it "should lookup the filename for the given class" do
      @module.filename_for_class(@model_a).should eql("stream.html")
    end
  end

  describe "#class_for_filename" do
    it "should lookup the class model for the given filename" do
      @module.class_for_filename("foo.html").should eql(@model_b)
    end
  end
end
