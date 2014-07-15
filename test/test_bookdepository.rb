require_relative 'helper'

class TestBookdepository < Minitest::Test
  def setup
    VCR.insert_cassette('bookdepository')
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
    @options.update(
      'keywords' => 'Architecture'
    )
    res = @client.books(@options)
    refute_empty res.to_h
  end

  def test_bestsellers
    res = @client.bestsellers(@options)
    refute_empty res.to_h
  end

  def test_comingsoon
    res = @client.comingsoon(@options)
    refute_empty res.to_h
  end

  def test_lookup
    @options.update(
      'isbn13' => '9780262062664',
    )
    res = @client.lookup(@options)
    refute_empty res.to_h
  end
end
