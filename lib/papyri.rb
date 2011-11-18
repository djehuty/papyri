require 'papyri/models/class'
require 'papyri/models/project'

require 'papyri/generator'

require 'fileutils'

module Papyri
  class << self
    def generate source_path, dest_path
      puts "Generating..."

      @classes = []
      @files = []
      @modules = []
      theme = Papyri::Theme.new "basic"

      conf = Papyri::Config.new "#{source_path}/papyri_config.yaml"
      project = Papyri::Project.new

      Dir.new(source_path).each do |f|
        source = "#{source_path}/#{f}"
        if f[0] != '.' and not File.directory?(source)
          unless f.rindex('.').nil?
            ext = f[f.rindex('.')+1..-1]
            filename = f[0..f.rindex('.')-1]
            dest = "."
            unless filename == "papyri_config"
              case ext
              when 'yaml', 'yml'
                cls = Papyri::Class.new(source, {}, conf)
                mod = cls.module

                # split mod
                mods = mod.split(conf.module_delimiter)
                cur_mod = project
                cur_fn = "project.html"

                mods[0..-2].each do |m|
                  found = false
                  cur_mod.modules.each do |mod|
                    if mod.name == m
                      cur_fn = cur_mod.filename_for_module mod
                      cur_mod = mod
                      found = true
                      break
                    end
                  end

                  unless found
                    if cur_mod.is_a? Papyri::Project
                      parent_filename = cur_fn
                    else
                      parent_filename = "../#{cur_fn[cur_fn.rindex("/")+1..-1]}"
                    end
                    mod = Papyri::Module.new(m, {:model=>cur_mod, :filename=>parent_filename})
                    cur_fn = "#{dest}/#{m}.html"
                    @modules << {:model=>mod, :filename=> "#{dest}/#{m}.html"}
                    cur_mod.add({:model=>mod, :filename=> "#{dest}/#{m}.html"})
                    cur_mod = mod
                  end

                  dest << "/#{m}"
                end

                dest << "/#{filename}.html"

                cls.parent = cur_mod
                cls.parent_filename = "../#{cur_fn[cur_fn.rindex("/")+1..-1]}"
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
        dest = "#{dest_path}/#{dest[2..-1]}"
        new_path = dest[0..dest.rindex('.')-1]
        FileUtils.mkdir_p new_path
        Papyri::Generator.new(m[:model], dest).generate theme
      end

      @classes.each do |c|
        dest = c[:filename]
        dest = "#{dest_path}/#{dest[2..-1]}"
        Papyri::Generator.new(c[:model], dest).generate theme
      end

      dest = dest_path + "/project.html"
      Papyri::Generator.new(project, dest).generate theme

      # Compile assets
      generate_assets_path theme.path, dest_path
    end

    private

    def generate_path source_path, dest_path
    end
    
    def generate_assets_path source_path, dest_path
      Dir.new(source_path).each do |f|
        full_path = "#{source_path}/#{f}"
        if f[0] != '.' and f != ".."
          if File.directory?(full_path)
            FileUtils.mkdir_p "#{dest_path}/#{f}"
            generate_assets_path full_path, "#{dest_path}/#{f}"
          elsif not f.rindex('.').nil?
            ext = f[f.rindex('.')+1..-1]
            filename = f[0..f.rindex('.')-1]
            dest = "#{dest_path}"
            case ext
            when 'sass'
              puts "Generating #{dest_path}/#{filename}.css"
              output = Tilt.new(full_path).render
              File.open("#{dest_path}/#{filename}.css", "w") do |f|
                f.write output
              end
            when 'js', 'css'
              FileUtils.cp full_path, "#{dest_path}/#{f}"
            end
          end
        end
      end
    end
  end
end
