require 'papyri/models/parameter'

module Papyri
  class Function
    attr_reader :name
    attr_reader :description
    attr_reader :parameters

    def initialize name, description, params = []
      @name = name
      @description = description

      @parameters = []
      unless params.nil?
        params.each do |p|
          @parameters << Papyri::Parameter.new(p["name"],
                                               p["description"],
                                               p["type"])
        end
      end
    end

    def to_s
      ret = "#{@name} ( "

      @parameters.each do |p|
        ret << "#{p.type} " unless p.type.nil?
        ret << "#{p.name}, "
      end

      if ret.end_with? ", "
        ret = ret[0..-3]
        ret << " "
      end

      ret << ")"

      ret
    end
  end
end
