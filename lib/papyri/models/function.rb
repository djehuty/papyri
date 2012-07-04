require 'papyri/models/parameter'

module Papyri
  class Function
    attr_reader :name
    attr_reader :description
    attr_reader :returns
    attr_reader :parameters

    def initialize name, description, returns = nil, params = [], config=nil, format = nil
      @format = format || ""
      @params = params || []

      @name = name
      @description = description

      unless returns.nil? || returns["description"].nil?
        @returns = Papyri::Parameter.new("", returns["description"],
                                         returns["type"])
      end

      @parameters = []
      unless params.nil?
        params.each do |p|
          @parameters << Papyri::Parameter.new(p["name"],
                                               p["description"],
                                               p["type"])
        end
      end
      @config = config
    end

    def to_s
      @config.parse_format_string(@format, nil, @name, @params)
    end
  end
end
