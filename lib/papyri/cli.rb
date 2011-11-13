require 'papyri'
require 'optparse'

module Papyri
  class CLI
    BANNER = <<-USAGE
    Usage:
      papyri generate [path=.] [-o target-path = -o .]

    Examples:
      Generate documents within the current directory:
      papyri generate

      Generate documents within the current directory with a target directory:
      papyri generate -o ../docs
    USAGE

    class << self
      def parse_options
        @opts = OptionParser.new do |opts|
          opts.banner = BANNER.gsub(/^[ ]{4}/, '')

          opts.separator ''
          opts.separator 'Options:'

          opts.on('-h', '--help', 'Display this help') do
            puts opts
            exit
          end
        end
      end

      def run
        begin
          parse_options
        rescue OptionParser::InvalidOption => e
          warn e
          exit -1
        end

        def fail
          puts @opts
          exit -1
        end

        if ARGV.empty?
          fail
        end

        case ARGV.first
        when 'generate'
          source = '.'
          source = ARGV[1] unless not ARGV[1]
          dest = '.'
          dest = ARGV[2] unless not ARGV[2]

          Papyri.generate(source, dest)
        end
      end
    end
  end
end
