require 'tilt'

require 'papyri/models/class'
require 'papyri/models/module'
require 'papyri/models/project'
require 'papyri/models/theme'

module Papyri
  class Generator
    def initialize object, destination
      puts "Generating #{destination}"
      @source = object
      @destination = destination
    end

    def generate theme
      if @source.is_a? Papyri::Class
        class_model = @source
        out = theme.generate_class class_model
      elsif @source.is_a? Papyri::Module
        module_model = @source
        out = theme.generate_module module_model
      elsif @source.is_a? Papyri::Project
        project = @source
        out = theme.generate_project project
      else
        out = ""
      end

      File.open(@destination, "wb") do |f|
        f.write out
      end
    end
  end
end
