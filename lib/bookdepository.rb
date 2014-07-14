require 'forwardable'
require 'bookdepository/request'

module Bookdepository
  class << self
    extend Forwardable

    def_delegators Request, :new, :config
  end
end
