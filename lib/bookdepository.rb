require 'forwardable'
require 'bookdepository/client'

module Bookdepository
  class << self
    extend Forwardable

    def_delegators Client, :new, :configure
  end
end
