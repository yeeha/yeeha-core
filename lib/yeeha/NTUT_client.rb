require 'yeeha/NTUT_client/query'

module Yeeha
  class NTUTClient
    attr_reader :studentId

    include Query

    def initialize(studentId)
      @studentId = studentId
    end
  end
end
