module Papyri
  class Project
    def initialize classes
      if classes.nil?
        @classes = []
      end

      @classes = classes
    end

    def classes
      @classes.map {|a| a[:model]}
    end

    def files
      @classes.map {|a| a[:filename]}
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
  end
end
