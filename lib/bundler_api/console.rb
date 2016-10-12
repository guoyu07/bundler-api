require 'irb'
require "irb/ext/loader"

module BundlerApi
  module ConsoleMethods
    def db
      @db ||= Sequel.connect(ENV['DATABASE_URL'], max_connections: 5)
    end

    def db_helper
      return @db_helper if defined? @db_helper
      gem_cache = BundlerApi::CacheInvalidator.new
      mutex     = Mutex.new
      @db_helper = BundlerApi::GemDBHelper.new(db, gem_cache, mutex)
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