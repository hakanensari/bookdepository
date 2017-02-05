require 'forwardable'
require 'countries'
require 'excon'
require 'bookdepository/config'
require 'bookdepository/parser'

module Bookdepository
  class Client
    extend Forwardable

    AVAILABLE_CURRENCIES = %w(USD GBP EUR CAD AUD SGD NZD).freeze

    def_delegators Config, :auth_key, :client_id

    def self.configure
      yield Config
    end

    %w(books bestsellers comingsoon lookup).each do |api_request|
      define_method(api_request) do |options|
        get(api_request, options)
      end
    end

    private

    def get(api_request, options = {})
      res = http.get(
        path: build_path(api_request),
        query: build_params(options)
      )

      Parser.new(res)
    end

    def http
      Excon.new('http://api.bookdepository.com', expects: 200)
    end

    def build_path(api_request)
      "/search/#{api_request}"
    end

    def build_params(options)
      options
        .merge(
          'clientId' => client_id,
          'authenticationKey' => auth_key
        )
        .tap { |params|
          if params.key?('countryCode')
            params['IP'] ||= '127.0.0.1'
            params['currencies'] ||= find_currency(params['countryCode'])
          end
        }
    end

    def find_currency(country_code)
      currency = ISO3166::Country[country_code].currency_code
      currency if AVAILABLE_CURRENCIES.include?(currency)
    end
  end
end
