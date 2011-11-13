# Project Model Specifications

require 'papyri/models/project'
require 'papyri/models/class'

describe Papyri::Project do
  before(:each) do
    classes = []
    @model_a = Papyri::Class.new("test/stream.yaml")
    classes << {:model => @model_a, 
      :filename => "stream.html"}
    @model_b = Papyri::Class.new("test/foo.yaml")
    classes << {:model => @model_b,
      :filename => "foo.html"}

    @project = Papyri::Project.new classes
  end

  describe "#classes" do
    it "should give the list of all models" do
      classes = @project.classes
      classes.include?(@model_a).should eql(true)
      classes.include?(@model_b).should eql(true)
      classes.length.should eql(2)
    end
  end
  
  describe "#files" do
    it "should give the list of all filenames" do
      files = @project.files
      files.include?("foo.html").should eql(true)
      files.include?("stream.html").should eql(true)
      files.length.should eql(2)
    end
  end

  describe "#filename_for_class" do
    it "should lookup the filename for the given class" do
      @project.filename_for_class(@model_a).should eql("stream.html")
    end
  end

  describe "#class_for_filename" do
    it "should lookup the class model for the given filename" do
      @project.class_for_filename("foo.html").should eql(@model_b)
    end
  end
end
