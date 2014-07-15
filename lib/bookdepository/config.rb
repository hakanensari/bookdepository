module Bookdepository
  module Config
    class << self
      attr_writer :auth_key, :client_id

      def auth_key
        @auth_key || ENV['BOOKDEPOSITORY_AUTH_KEY']
      end

      def client_id
        @client_id || ENV['BOOKDEPOSITORY_CLIENT_ID']
      end
    end
  end
end
