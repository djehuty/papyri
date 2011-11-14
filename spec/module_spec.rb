# Module Model Specifications

require 'papyri/models/module'
require 'papyri/models/class'

describe Papyri::Module do
  before(:each) do
    classes = []
    @model_a = Papyri::Module.new "io", {}
    classes << {:model => @model_a, 
      :filename => "stream.html"}
    @model_b = Papyri::Module.new "net", {}
    classes << {:model => @model_b,
      :filename => "foo.html"}

    @model_c = Papyri::Class.new("test/stream.yaml")
    classes << {:model => @model_c, 
      :filename => "stream.html"}
    @model_d = Papyri::Class.new("test/foo.yaml")
    classes << {:model => @model_d,
      :filename => "foo.html"}

    @module = Papyri::Module.new "io", classes
  end

  describe "#new" do
    it "generates an instance with the given name" do
      @module.name.should eql("io")
    end

    it "should allow creation without a module list" do
      mod = Papyri::Module.new "io"
      mod.modules.length.should eql(0)
      mod.classes.length.should eql(0)
      mod.files.length.should eql(0)
    end
  end

  describe "#add" do
    it "should add to the list of classes when a Class is passed" do
      @module.add({:model=>Papyri::Class.new("test/foo.yaml"), :filename=>"foo.html"})
      @module.modules.length.should eql(2)
      @module.classes.length.should eql(3)
      @module.files.length.should eql(5)
    end

    it "should add to the list of modules when a Module is passed" do
      @module.add({:model=>Papyri::Module.new("drawing", {}), :filename=>"drawing.html"})
      @module.modules.length.should eql(3)
      @module.classes.length.should eql(2)
      @module.files.length.should eql(5)
    end
  end

  describe "#classes" do
    it "should give the list of all models" do
      classes = @module.classes
      classes.include?(@model_c).should eql(true)
      classes.include?(@model_d).should eql(true)
      classes.length.should eql(2)
    end
  end

  describe "#modules" do
    it "should give the list of all module models" do
      modules = @module.modules
      modules.include?(@model_a).should eql(true)
      modules.include?(@model_b).should eql(true)
      modules.length.should eql(2)
    end
  end
 
  describe "#files" do
    it "should give the list of all filenames" do
      files = @module.files
      files.include?("foo.html").should eql(true)
      files.include?("stream.html").should eql(true)
      files.length.should eql(4)
    end
  end

  describe "#filename_for_class" do
    it "should lookup the filename for the given class" do
      @module.filename_for_class(@model_c).should eql("stream.html")
    end
  end

  describe "#class_for_filename" do
    it "should lookup the class model for the given filename" do
      @module.class_for_filename("foo.html").should eql(@model_d)
    end
  end

  describe "#filename_for_module" do
    it "should lookup the filename for the given class" do
      @module.filename_for_module(@model_a).should eql("stream.html")
    end
  end

  describe "#module_for_filename" do
    it "should lookup the class model for the given filename" do
      @module.module_for_filename("foo.html").should eql(@model_b)
    end
  end
end
