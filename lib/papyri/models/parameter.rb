module Papyri
  class Parameter
    attr_reader :name
    attr_reader :description
    attr_reader :type

    def initialize name, description, type = nil
      @name = name
      @description = description
      @type = type
    end
  end
end
