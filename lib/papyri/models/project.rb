module Papyri
  class Project
    def initialize modules
      if modules.nil?
        modules = []
      end

      @modules = modules
    end

    def modules
      @modules.map {|a| a[:model]}
    end

    def files
      @modules.map {|a| a[:filename]}
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
