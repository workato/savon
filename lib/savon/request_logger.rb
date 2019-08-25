require "savon/log_message"

module Savon
  class RequestLogger

    def initialize(globals)
      @globals = globals
    end

    def log_request(request)
      logger.info  { "SOAP request: #{request.url}" }
      logger.info  { headers_to_log(request.headers) }
      logger.debug { body_to_log(request.body) }
    end

    def log_response(response, request, elapsed)
      logger.info  { "SOAP response (status #{response.code})" }
      logger.debug { body_to_log(response.body) }
    end

    def logger
      @globals[:logger]
    end

    def log?
      @globals[:log]
    end

    private

    def headers_to_log(headers)
      headers.map { |key, value| "#{key}: #{value}" }.join(", ")
    end

    def body_to_log(body)
      LogMessage.new(body, @globals[:filters], @globals[:pretty_print_xml]).to_s
    end

  end
end
