require 'yaml'

module Papyri
  class Config
    def initialize config_file=nil
      @filename = config_file
      @config = {}
      load_config unless config_file.nil?
    end

    def function_format
      @config["function_format"] || "%n(%p, %p)"
    end

    def constructor_name
      @config["constructor_name"] || "initialize"
    end

    def language
      @config["language"] || "ruby"
    end

    private

    def load_config
      @config = YAML.load_file(@filename)
    end
  end
end
