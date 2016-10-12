require 'irb'
require "irb/ext/loader"

module BundlerApi
  module ConsoleMethods
    def db
      @db ||= Sequel.connect(ENV['DATABASE_URL'], max_connections: 5)
    end
  end

  class Console
    class << self
      def start
        IRB.conf[:IRB_NAME] = "bundler-api console"
        ARGV.clear
        if defined?(IRB::ExtendCommandBundle)
          IRB::ExtendCommandBundle.send :include, ConsoleMethods
        end
        IRB.start
      end
    end
  end
end