# Project Model Specifications

require 'papyri/models/project'
require 'papyri/models/class'

describe Papyri::Project do
  before(:each) do
    modules = []
    @model_a = Papyri::Module.new "io", {}
    modules << {:model => @model_a, 
      :filename => "stream.html"}
    @model_b = Papyri::Module.new "net", {}
    modules << {:model => @model_b,
      :filename => "foo.html"}

    @model_c = Papyri::Class.new("test/stream.yaml")
    modules << {:model => @model_c, 
      :filename => "stream.html"}
    @model_d = Papyri::Class.new("test/foo.yaml")
    modules << {:model => @model_d,
      :filename => "foo.html"}

    @project = Papyri::Project.new modules
  end

  describe "#modules" do
    it "should give the list of all module models" do
      modules = @project.modules
      modules.include?(@model_a).should eql(true)
      modules.include?(@model_b).should eql(true)
      modules.length.should eql(2)
    end
  end
  
  describe "#files" do
    it "should give the list of all filenames" do
      files = @project.files
      files.include?("foo.html").should eql(true)
      files.include?("stream.html").should eql(true)
      files.length.should eql(4)
    end
  end

  describe "#classes" do
    it "should give the list of all class models" do
      classes = @project.classes
      classes.include?(@model_c).should eql(true)
      classes.include?(@model_d).should eql(true)
      classes.length.should eql(2)
    end
  end

  describe "#filename_for_module" do
    it "should lookup the filename for the given class" do
      @project.filename_for_module(@model_a).should eql("stream.html")
    end
  end

  describe "#module_for_filename" do
    it "should lookup the class model for the given filename" do
      @project.module_for_filename("foo.html").should eql(@model_b)
    end
  end

  describe "#filename_for_class" do
    it "should lookup the filename for the given class" do
      @project.filename_for_class(@model_c).should eql("stream.html")
    end
  end

  describe "#class_for_filename" do
    it "should lookup the class model for the given filename" do
      @project.class_for_filename("foo.html").should eql(@model_d)
    end
  end
end
