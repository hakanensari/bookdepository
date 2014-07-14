require 'delegate'
require 'multi_xml'

module Bookdepository
  class Parser < SimpleDelegator
    def to_h
      MultiXml.parse(body)
    end
  end
end
