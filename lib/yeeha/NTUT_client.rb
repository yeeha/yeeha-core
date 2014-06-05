require 'yeeha/NTUT_client/loggin/logging'
require 'yeeha/NTUT_client/middle/middle'

module Yeeha
  class NTUTClient

    include Logging
    include Yeeha::Middle::CourseSelection

    attr_reader :student_id

    def initialize(student_id)
      @client = self
      @student_id = student_id
    end
  end
end
