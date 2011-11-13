module Papyri
  class Theme
    def initialize theme_name
      @theme_name = theme_name
      if not File.exists?("lib/papyri/views/#{@theme_name}/class.haml")
        raise "Theme not found"
      end
    end

    def generate_class cls
      Tilt::HamlTemplate.new("lib/papyri/views/#{@theme_name}/class.haml", 1, {:format => :html5}).render cls
    end

    def generate_navigation project
      Tilt::HamlTemplate.new("lib/papyri/views/#{@theme_name}/navigation.haml", 1, {:format => :html5}).render project
    end
  end
end
