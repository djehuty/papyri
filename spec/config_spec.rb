# Config Model Specifications

require 'papyri/models/config'

describe Papyri::Config do
  describe "#new" do
    before(:each) do
      @cfg = Papyri::Config.new("test/papyri_config.yaml")
    end

    it "generates an instance for a particular config yaml" do
      @cfg.nil?.should eql(false)
    end

    it "will produce an error when a config file is not found" do
      lambda { Papyri::Config.new("test/no_such_config.yaml") }.should raise_error(Errno::ENOENT)
    end

    it "pulls the function format from the config file" do
      @cfg.function_format.should eql("%n(%t %p, %t %p)")
    end

    it "pulls the language from the config file" do
      @cfg.language.should eql("D")
    end

    it "pulls the constructor name from the config file" do
      @cfg.constructor_name.should eql("this")
    end

    it "pulls the module delimiter from the config file" do
      @cfg.module_delimiter.should eql(".")
    end

    it "has an acceptable default for function format when none is specified" do
      cfg = Papyri::Config.new
      cfg.function_format.should eql("%n(%p, %p)")
    end

    it "has an acceptable default for language when none is specified" do
      cfg = Papyri::Config.new
      cfg.language.should eql("ruby")
    end

    it "has an acceptable default for constructor name when none is specified" do
      cfg = Papyri::Config.new
      cfg.constructor_name.should eql("initialize")
    end

    it "has an acceptable default for module delimiter when none is specified" do
      cfg = Papyri::Config.new
      cfg.module_delimiter.should eql("/")
    end
  end
end
