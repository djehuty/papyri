require 'papyri/models/class'
require 'papyri/models/project'

require 'papyri/generator'

module Papyri
  class << self
    def generate source_path, dest_path
      puts "Generating..."

      @files = []
      @classes = []

      Dir.new(source_path).each do |f|
        source = "#{source_path}/#{f}"
        if f[0] != '.' and not File.directory?(source)
          unless f.rindex('.').nil?
            ext = f[f.rindex('.')+1..-1]
            filename = f[0..f.rindex('.')-1]
            dest = "#{dest_path}/#{filename}"
            unless filename == "papyri_config"
              case ext
              when 'yaml'
                dest << ".html"
                cls = Papyri::Class.new(source)
                Papyri::Generator.new(cls, dest).generate
                @files << filename.intern
                @classes << {:model=>cls, :filename=>dest}
              end
            end
          end
        end
      end

      nav = Papyri::Project.new(@classes)
      dest = dest_path + "/navigation.html"
      Papyri::Generator.new(nav, dest).generate
    end
  end
end
