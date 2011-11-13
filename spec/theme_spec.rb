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

  end

  describe "#generate" do
    before(:each) do
      @theme = Papyri::Theme.new "basic"

      @name = "Stream"
      @module = "io.stream"
      @constructors = []
      @methods = []
      @properties = []
      @events = []
    end

    it "generates HTML output" do
      output = @theme.generate self
      output.should match /<HTML.*?>/i
    end

    it "generates HTML5 output" do
      output = @theme.generate self
      output.should match /<!DOCTYPE html>/i
    end
  end
end
