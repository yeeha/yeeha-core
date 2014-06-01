require 'yeeha/NTUT_client/logging'
require 'yeeha/NTUT_client/query'

module Yeeha
  module NTUTClient
    include Logging
    extend Logging

    include Query
    extend Query
  end
end
