# Class Model Specifications
require 'papyri/models/class'

require 'papyri/models/config'

describe Papyri::Class do
  describe "#new" do
    before(:each) do
      @cls = Papyri::Class.new("test/stream.yaml")
    end

    it "uses the default config model for the constructor name when no config model is given" do
      default_name = Papyri::Config.new.constructor_name
      @cls.constructors[0].name.should eql(default_name)
    end

    it "uses the given config model for the constructor name" do
      config = Papyri::Config.new("test/papyri_config.yaml")
      cls = Papyri::Class.new("test/stream.yaml", {}, config)
      constructor_name = config.constructor_name
      cls.constructors[0].name.should eql(constructor_name)
    end

    it "reads the class name from the yaml file" do
      @cls.name.should eql("Stream")
    end

    it "reads the module name from the yaml file" do
      @cls.module.should eql("io.stream")
    end

    it "reads the description from the yaml file" do
      @cls.description.should eql("This class represents a data stream of arbitrary bytes.")
    end

    it "reads the constructors from the yaml file" do
      @cls.constructors.length.should eql(2)
      @cls.constructors[0].description.should eql("This constructor will create an unattached stream.")
      @cls.constructors[1].description.should eql("This constructor will create a stream attached to predefined functions.")
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

    it "reads the dependencies from the yaml file" do
      @cls.dependencies.length.should eql(2)
      @cls.dependencies[0].should eql("io.foo")
      @cls.dependencies[1].should eql("io.bar")
    end

    it "has at least an empty array if no dependencies are listed" do
      cls = Papyri::Class.new("test/foo.yaml")
      cls.dependencies.should eql([])
    end
  end

  describe "#path_url" do
    it "yields a url relative to the root" do
      cls = Papyri::Class.new("test/stream.yaml")
      project = Papyri::Project.new
      cls.parent = Papyri::Module.new "io", {:model => project, :filename => "project.html"}

      cls.path_url("css/main.css").should eql("../css/main.css")
    end
  end

  describe "#module_path" do
    it "generates a url based upon the module using a default config parameter" do
      cls = Papyri::Class.new("test/stream.yaml",
                              {:model => Papyri::Project.new({}), :filename => "foo.html"})
      cls.module_path("io/foo").should eql("io/foo.html")
    end

    it "generates a url based upon the module using the config parameter" do
      cls = Papyri::Class.new("test/stream.yaml",
                              {:model => Papyri::Project.new({}), :filename => "foo.html"},
                              Papyri::Config.new("test/papyri_config.yaml"))
      cls.module_path("io.foo").should eql("io/foo.html")
    end
  end
end
