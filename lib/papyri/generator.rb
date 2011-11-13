require 'tilt'

require 'papyri/models/class'
require 'papyri/models/theme'
require 'papyri/models/project'

module Papyri
  class Generator
    def initialize object, destination
      puts
      puts "Generating #{destination}"
      @source = object
      @destination = destination
    end

    def generate
      theme = Papyri::Theme.new "basic"
      if @source.is_a? Papyri::Class
        class_model = @source
        out = theme.generate_class class_model
      elsif @source.is_a? Papyri::Project
        project = @source
        out = theme.generate_navigation project
      else
        out ""
      end

      File.open(@destination, "wb") do |f|
        f.write out
      end
    end
  end
end
