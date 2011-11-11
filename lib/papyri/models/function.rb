module Papyri
  class Function
    attr_reader :name
    attr_reader :description

    def initialize name, description
      @name = name
      @description = description
    end

    def to_s
      @name
    end
  end
end
