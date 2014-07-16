require_relative 'helper'

class TestEdgeCases < Bookdepository::Test
  def setup
    use_mock_credentials_if_none_provided
    VCR.insert_cassette('edge_cases')
    @client = Bookdepository.new
  end

  def teardown
    VCR.eject_cassette
  end

  def test_asin
    parser = @client.books(
      'countryCode' => 'GB',
      'keywords' => 'B00IE3UR08'
    )
    skip('ASIN returns bogus matches')
    assert_equal 0, parser.to_h['result']['resultset']['results'].to_i
  end
end
