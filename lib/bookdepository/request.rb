require 'countries'
require 'excon'
require 'bookdepository/config'
require 'bookdepository/parser'

module Bookdepository
  class Request
    AVAILABLE_CURRENCIES = %w(USD GBP EUR CAD AUD SGD NZD)

    def self.config
      yield Config
    end

    %w(books bestsellers comingsoon lookup).each do |request_type|
      define_method(request_type) do |options|
        get(request_type, options)
      end
    end

    private

    def get(type, options = {})
      res = http.get(
        path: build_path(type),
        query: build_params(options)
      )

      Parser.new(res)
    end

    def http
      Excon.new('http://api.bookdepository.com', expects: 200)
    end

    def build_path(type)
      "/search/#{type}"
    end

    def build_params(options)
      options
        .merge(
          'clientId' => Config.client_id,
          'authenticationKey' => Config.auth_key
        )
        .tap { |params|
          if params.has_key?('countryCode')
            params['IP'] ||= '127.0.0.1'
            params['currencies'] ||= find_currency(params['countryCode'])
          end
        }
    end

    def find_currency(country_code)
      currency = Country[country_code].currency_code
      currency if AVAILABLE_CURRENCIES.include?(currency)
    end
  end
end
