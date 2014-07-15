require 'minitest/autorun'
require 'vcr'
require_relative '../lib/bookdepository'

VCR.configure do |c|
  c.hook_into :excon
  c.cassette_library_dir = 'test/vcr_cassettes'
  c.filter_sensitive_data('CLIENT_ID') { ENV['BOOK_DEPOSITORY_CLIENT_ID'] }
  c.filter_sensitive_data('AUTH_KEY') { ENV['BOOK_DEPOSITORY_AUTH_KEY'] }
  c.default_cassette_options = {
    record: :none,
    match_requests_on: [:method,
      VCR.request_matchers.uri_without_param('authenticationKey', 'clientId')]
  }
end
