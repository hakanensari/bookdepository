module Bookdepository
  module Config
    class << self
      attr_accessor :auth_key, :client_id
    end

    @auth_key = ENV['BOOK_DEPOSITORY_AUTH_KEY']
    @client_id = ENV['BOOK_DEPOSITORY_CLIENT_ID']
  end
end
