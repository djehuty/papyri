require 'papyri/models/class'

module Papyri
  class Module
    attr_reader :name
    attr_reader :parent
    attr_reader :parent_filename

    def initialize name, parent, classes=nil
      @name = name
      @parent = parent[:model]
      @parent_filename = parent[:filename]

      if classes.nil?
        classes = []
      end

      @classes = []
      @modules = []

      classes.each do |f|
        if f[:model].is_a? Papyri::Class
          @classes << f
        elsif f[:model].is_a? Papyri::Module
          @modules << f
        end
      end
    end

    def add obj
      if obj[:model].is_a? Papyri::Class
        @classes << obj
      elsif obj[:model].is_a? Papyri::Module
        @modules << obj
      else
        nil
      end
    end

    def modules
      @modules.map {|a| a[:model]}
    end

    def classes
      @classes.map {|a| a[:model]}
    end

    def files
      @classes.map {|a| a[:filename]} + @modules.map {|a| a[:filename]}
    end

    def filename_for_class class_model
      @classes.each do |c|
        if c[:model] == class_model
          return c[:filename]
        end
      end
      nil
    end

    def class_for_filename filename
       @classes.each do |c|
        if c[:filename] == filename
          return c[:model]
        end
      end
      nil
    end

    def filename_for_module module_model
      @modules.each do |m|
        if m[:model] == module_model
          return m[:filename]
        end
      end
      nil
    end

    def module_for_filename filename
       @modules.each do |m|
        if m[:filename] == filename
          return m[:model]
        end
      end
      nil
    end
  end
end
