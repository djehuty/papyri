require 'yaml'

require 'papyri/models/function'
require 'papyri/models/config'

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

    def initialize filename, config=nil
      @filename = filename
      
      if config.nil?
        config = Papyri::Config.new
      end
      @config = config

      load_from_yaml
    end

    private

    def load_from_yaml
      @yaml = YAML.load_file(@filename)

      @module = @yaml["module"]
      @name = @yaml["class"]

      @constructors = []
      @properties = []
      @methods = []
      @events = []

      @dependencies = []
      
      unless @yaml["dependencies"].nil? or not @yaml["dependencies"].is_a? Array
        @yaml["dependencies"].each do |dependency|
          @dependencies << dependency
        end
      end

      unless @yaml["functions"].nil?
        @yaml["functions"].each do |function|
          if function["property"]
            f = Papyri::Function.new function["property"], 
                                     function["description"],
                                     function["parameters"]
            @properties << f
          elsif function["method"]
            f = Papyri::Function.new function["method"], 
                                     function["description"],
                                     function["parameters"]
            @methods << f
          elsif function["event"]
            f = Papyri::Function.new function["event"], 
                                     function["description"],
                                     function["parameters"]
            @events << f
          elsif function["constructor"]
            f = Papyri::Function.new @config.constructor_name, 
                                     function["constructor"],
                                     function["parameters"]
            @constructors << f
          end
        end
      end
    end
  end
end
