# Function Model Specifications
require 'papyri/models/function'

describe Papyri::Function do
  describe "#new" do
    it "generates a class with the specified name" do
      f = Papyri::Function.new "foobar", "Does a foo bar"
      f.name.should eql("foobar")
    end

    it "generates a class with the specified description" do
      f = Papyri::Function.new "foobar", "Does a foo bar"
      f.description.should eql("Does a foo bar")
    end
  end
end
