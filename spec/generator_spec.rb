# Generator Specifications
require 'papyri/generator'

require 'papyri/models/class'
require 'papyri/models/module'
require 'papyri/models/project'

describe Papyri::Generator do
  describe "#new" do
    after(:each) do
      if File.exists?("test/foo")
        File.unlink("test/foo")
      end
    end

    it "generates an HTML file from a Class model" do
      model_a = Papyri::Class.new("test/stream.yaml", {:model => Papyri::Project.new {}, :filename => "foo"} )

      g = Papyri::Generator.new(model_a, "test/foo")
      g.generate Papyri::Theme.new("basic")

      File.exists?("test/foo").should eql(true)
      f = File.read("test/foo")
      f.should match /<HTML.*?>/i
    end

    it "generates an HTML file from a Module model" do
      model_a = Papyri::Module.new("io", {:model => Papyri::Project.new {}, :filename => "foo"} )

      g = Papyri::Generator.new(model_a, "test/foo")
      g.generate Papyri::Theme.new("basic")

      File.exists?("test/foo").should eql(true)
      f = File.read("test/foo")
      f.should match /<HTML.*?>/i
    end

    it "generates an HTML file from a Project model" do
      modules = []
      model_a = Papyri::Module.new "io", {}
      modules << {:model => model_a, 
        :filename => "stream.html"}
      model_b = Papyri::Module.new "net", {}
      modules << {:model => model_b,
        :filename => "foo.html"}

      model_c = Papyri::Class.new("test/stream.yaml")
      modules << {:model => model_c, 
        :filename => "stream.html"}
      model_d = Papyri::Class.new("test/foo.yaml")
      modules << {:model => model_d,
        :filename => "foo.html"}

      project = Papyri::Project.new modules

      g = Papyri::Generator.new(project, "test/foo")
      g.generate Papyri::Theme.new("basic")

      File.exists?("test/foo").should eql(true)
      f = File.read("test/foo")
      f.should match /<HTML.*?>/i
    end

    it "generates an empty file for an object it does not understand" do
      g = Papyri::Generator.new(Object, "test/foo")
      g.generate Papyri::Theme.new("basic")

      File.exists?("test/foo").should eql(true)
      File.size("test/foo").should eql(0)
    end
  end
end
