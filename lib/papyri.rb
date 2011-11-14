require 'papyri/models/class'
require 'papyri/models/project'

require 'papyri/generator'

module Papyri
  class << self
    def generate source_path, dest_path
      puts "Generating..."

      @classes = []
      @files = []
      @modules = []

      conf = Papyri::Config.new "#{source_path}/papyri_config.yaml"
      project = Papyri::Project.new

      Dir.new(source_path).each do |f|
        source = "#{source_path}/#{f}"
        if f[0] != '.' and not File.directory?(source)
          unless f.rindex('.').nil?
            ext = f[f.rindex('.')+1..-1]
            filename = f[0..f.rindex('.')-1]
            dest = "#{dest_path}"
            unless filename == "papyri_config"
              case ext
              when 'yaml'
                cls = Papyri::Class.new(source)
                mod = cls.module

                # split mod
                mods = mod.split(conf.module_delimiter)
                cur_mod = project

                mods[0..-2].each do |m|
                  found = false
                  cur_mod.modules.each do |mod|
                    if mod.name == m
                      cur_mod = mod
                      found = true
                      break
                    end
                  end

                  unless found
                    mod = Papyri::Module.new(m)
                    @modules << {:model=>mod, :filename=>"#{dest}/#{m}.html"}
                    cur_mod.add({:model=>mod, :filename=>"#{dest}/#{m}.html"})
                    cur_mod = mod
                  end

                  dest << "/#{m}"
                end

                dest << "/#{filename}.html"

                @classes << {:model=>cls, :filename=>dest}
                cur_mod.add({:model=>cls, :filename=>dest})

                @files << filename.intern
              end
            end
          end
        end
      end

      @modules.each do |m|
        dest = m[:filename]
        new_path = dest[0..dest.rindex('.')-1]
        begin
          Dir.mkdir(new_path)
        rescue SystemCallError
        end
        Papyri::Generator.new(m[:model], dest).generate
      end

      @classes.each do |c|
        Papyri::Generator.new(c[:model], c[:filename]).generate
      end

      dest = dest_path + "/project.html"
      Papyri::Generator.new(project, dest).generate
    end
  end
end
