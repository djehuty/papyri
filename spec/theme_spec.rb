# Theme Model Specification

require 'papyri/models/theme'

describe Papyri::Theme do
  describe "#new" do
    it "generates an instance for a existing theme" do
      theme = Papyri::Theme.new "basic"
    end

    it "fails for a theme that does not exist" do
      lambda { theme = Papyri::Theme.new "theme_that_does_not_exist" }.should raise_error("Theme not found")
    end

    it "generates an instance that points to the current path" do
      theme = Papyri::Theme.new "basic"
      theme.path.should eql("lib/papyri/views/basic")
    end

    it "generates an instance that can recall its name" do
      theme = Papyri::Theme.new "basic"
      theme.name.should eql("basic")
    end

  end

  describe "#generate_class" do
    before(:each) do
      @theme = Papyri::Theme.new "basic"

      cls = Class.new do
        def initialize
          @parent = Papyri::Project.new
          @parent_filename = "project.html"

          @name = "Stream"
          @module = "io.stream"
          @constructors = []
          @methods = []
          @properties = []
          @events = []
          @dependencies = []
        end

        def path_url path
          path
        end
      end
      @cls = cls.new
    end

    it "generates HTML output" do
      output = @theme.generate_class @cls
      output.should match /<HTML.*?>/i
    end

    it "generates HTML5 output" do
      output = @theme.generate_class @cls
      output.should match /<!DOCTYPE html>/i
    end
  end

  describe "#generate_module" do
    before(:each) do
      @theme = Papyri::Theme.new "basic"

      cls = Class.new do
        def initialize
          @parent = Papyri::Project.new
          @parent_filename = "project.html"

          @classes = []
          model_a = Papyri::Class.new("test/stream.yaml")
          @classes << {:model => model_a, 
            :filename => "stream.html"}
          model_b = Papyri::Class.new("test/foo.yaml")
          @classes << {:model => model_b,
            :filename => "foo.html"}

          @modules = []
        end

        def path_url path
          path
        end
      end

      @cls = cls.new
    end

    it "generates HTML output" do
      output = @theme.generate_module @cls
      output.should match /<HTML.*?>/i
    end

    it "generates HTML5 output" do
      output = @theme.generate_module @cls
      output.should match /<!DOCTYPE html>/i
    end
  end

  describe "#generate_project" do
    before(:each) do
      @theme = Papyri::Theme.new "basic"

      cls = Class.new do
        def initialize
          @classes = []
          model_a = Papyri::Class.new("test/stream.yaml")
          @classes << {:model => model_a, 
            :filename => "stream.html"}
          model_b = Papyri::Class.new("test/foo.yaml")
          @classes << {:model => model_b,
            :filename => "foo.html"}

          @modules = []
        end

        def path_url path
          path
        end
      end

      @cls = cls.new
    end

    it "generates HTML output" do
      output = @theme.generate_project @cls
      output.should match /<HTML.*?>/i
    end

    it "generates HTML5 output" do
      output = @theme.generate_project @cls
      output.should match /<!DOCTYPE html>/i
    end
  end
end
