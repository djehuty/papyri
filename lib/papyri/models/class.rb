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

    attr_reader :description

    attr_reader :name
    attr_reader :module

    attr_accessor :parent
    attr_accessor :parent_filename

    attr_reader :dependencies

    def initialize filename, parent={}, config=nil
      @filename = filename

      @parent = parent[:model]
      @parent_filename = parent[:filename]
      
      if config.nil?
        config = Papyri::Config.new
      end
      @config = config
      @format = @config.parse_format_string(@config.function_format, @name)

      load_from_yaml
    end

    def path_url path
      ret = ""
      cur_mod = @parent
      until cur_mod.is_a? Papyri::Project do
        ret << "../"
        cur_mod = cur_mod.parent
      end

      ret << path
    end

    def module_path module_string
      ret = ""
      path = module_string.gsub(@config.module_delimiter, "/")
      path_url "#{path}.html"
    end

    private

    def load_from_yaml
      @yaml = YAML.load_file(@filename)

      @module = @yaml["module"]
      @name = @yaml["class"]

      @description = @yaml["description"]

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
                                     {},
                                     function["parameters"],
                                     @config,
                                     @format
            @properties << f
          elsif function["method"]
            f = Papyri::Function.new function["method"], 
                                     function["description"],
                                     {"description"=>function["returns"], "type"=>function["return-type"]},
                                     function["parameters"],
                                     @config,
                                     @format
            @methods << f
          elsif function["event"]
            f = Papyri::Function.new function["event"], 
                                     function["description"],
                                     {"description"=>function["returns"], "type"=>function["return-type"]},
                                     function["parameters"],
                                     @config,
                                     @format
            @events << f
          elsif function["constructor"]
            f = Papyri::Function.new @config.constructor_name, 
                                     function["constructor"],
                                     {},
                                     function["parameters"],
                                     @config,
                                     @format
            @constructors << f
          end
        end
      end
    end
  end
end
