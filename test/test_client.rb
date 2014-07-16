require_relative 'helper'

class TestClient < Bookdepository::Test
  def setup
    use_mock_credentials_if_none_provided
    VCR.insert_cassette('client')
    @client = Bookdepository.new
    @options = { 'countryCode' => 'GB' }
  end

  def teardown
    VCR.eject_cassette
  end

  def test_configure
    Bookdepository.configure do |c|
      c.client_id = '123'
    end
    assert_equal '123', @client.client_id
  end

  def test_books
    @options.update('keywords' => 'Architecture')
    parser = @client.books(@options)
    refute_empty parser.to_h
  end

  def test_bestsellers
    parser = @client.bestsellers(@options)
    refute_empty parser.to_h
  end

  def test_comingsoon
    parser = @client.comingsoon(@options)
    refute_empty parser.to_h
  end

  def test_lookup
    @options.update('isbn13' => '9780262062664')
    parser = @client.lookup(@options)
    refute_empty parser.to_h
  end
end
