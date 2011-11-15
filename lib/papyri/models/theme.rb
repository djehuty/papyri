module Papyri
  class Theme
    attr_reader :name
    attr_reader :path

    def initialize theme_name
      @name = theme_name
      @path = "lib/papyri/views/#{@name}"
      if not File.exists?("#{@path}/class.haml")
        raise "Theme not found"
      end
    end

    def generate_class cls
      Tilt::HamlTemplate.new("#{@path}/class.haml", 1, {:format => :html5}).render cls
    end

    def generate_module mod
      Tilt::HamlTemplate.new("#{@path}/module.haml", 1, {:format => :html5}).render mod
    end

    def generate_project project
      Tilt::HamlTemplate.new("#{@path}/project.haml", 1, {:format => :html5}).render project
    end
  end
end
