require 'yaml'

module Papyri
  class Config
    def initialize config_file=nil
      @filename = config_file
      @config = {}
      load_config unless config_file.nil?
    end

    def function_format
      @config["function_format"] || "%f(%p, %p)"
    end

    def constructor_name
      @config["constructor_name"] || "initialize"
    end

    def language
      @config["language"] || "ruby"
    end

    def module_delimiter
      @config["module_delimiter"] || "/"
    end

    def parse_format_string(string,
                            class_name = nil,
                            function_name = nil,
                            params = nil)

      unless class_name.nil?
        string = string.gsub "%c", class_name
      end

      unless function_name.nil?
        string = string.gsub "%f", function_name
      end

      # Parameter Replacement
      unless params.nil?
        start_p = string.index "%p"
        start_t = string.index "%t"

        unless start_t.nil?
          start = [start_p, start_t].min
        else
          start = start_p
        end

        last_p = string.rindex "%p"
        last_t = string.rindex "%t"

        unless last_t.nil?
          last = [last_p, last_t].min
          end_of_params = [last_p, last_t].max
        else
          last = last_p
          end_of_params = last_p
        end

        repeated = string[start..last-1]

        expansion = params[0..-2].reduce("") do |a, e|
          "#{a}#{repeated.gsub("%p", e["name"]).gsub("%t", e["type"])}"
        end

        if params.length > 0
          string = "#{string[0..start-1]}#{expansion}#{string[last..-1]}"
          string.gsub!("%p", params[-1]["name"])
          string.gsub!("%t", params[-1]["type"])
        else
          string = "#{string[0..start-1]}#{string[end_of_params+2..-1]}"
        end
      end

      string
    end

    private

    def load_config
      @config = YAML.load_file(@filename)
    end
  end
end
