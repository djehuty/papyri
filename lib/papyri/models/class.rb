require 'yaml'

require 'papyri/models/function'

module Papyri
  class Class
    attr_reader :filename

    attr_reader :constructors
    attr_reader :properties
    attr_reader :methods
    attr_reader :events

    attr_reader :name
    attr_reader :module

    attr_reader :dependencies

    def initialize filename
      @filename = filename
      load_from_yaml filename
    end

    private

    def load_from_yaml filename
      @yaml = YAML.load_file(filename)

      @module = @yaml["module"]
      @name = @yaml["class"]

      @constructors = []
      @properties = []
      @methods = []
      @events = []

      @dependencies = []
      
      unless @yaml["dependencies"].nil?
        @yaml["dependencies"].each do |dependency|
        end
      end

      unless @yaml["functions"].nil?
        @yaml["functions"].each do |function|
          if function["property"]
            f = Papyri::Function.new function["property"], 
                                     function["description"]
            @properties << f
          elsif function["method"]
            f = Papyri::Function.new function["method"], 
                                     function["description"]
            @methods << f
          elsif function["event"]
            f = Papyri::Function.new function["event"], 
                                     function["description"]
            @events << f
          elsif function["constructor"]
            f = Papyri::Function.new "", 
                                     function["constructor"]
            @constructors << f
          end
        end
      end
    end
  end
end
