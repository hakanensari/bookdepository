module Bookdepository
  module Config
    class << self
      attr_accessor :auth_key, :client_id
    end

    @auth_key = ENV['BOOKDEPOSITORY_AUTH_KEY']
    @client_id = ENV['BOOKDEPOSITORY_CLIENT_ID']
  end
end
