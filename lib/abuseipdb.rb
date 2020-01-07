require "abuseipdb/version"
require "abuseipdb/client"

module Abuseipdb
  class Error < StandardError; end

  class << self
    attr_accessor :configuration

    def client
      @client = Abuseipdb::Client.new(configuration)
    end

    def check
      client.check
    end

    def report
      client.report
    end

    def blacklist
      client.blacklist
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
