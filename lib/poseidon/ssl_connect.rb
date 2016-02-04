module Poseidon
  # Provides a ssl connection to kafka cluster

  class SslConnect
    SSL_VERSION = :TLSv1
    VERIFY_MODE = OpenSSL::SSL::VERIFY_PEER

    def initialize(ca_cert_path)
      @ssl_context = OpenSSL::SSL::SSLContext.new
      @ssl_context.ca_file = ca_cert_path
      @ssl_context.verify_mode = VERIFY_MODE
      @ssl_context.ssl_version = SSL_VERSION
    end

    def get_socket(host, port)
      tcp_client = TCPSocket.new(host, port)
      @socket = OpenSSL::SSL::SSLSocket.new(tcp_client, @ssl_context)
      @socket.connect
    end
  end
end

