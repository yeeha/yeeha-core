require 'yeeha/NTUT_client/middle/middle'

module Yeeha
  module Model
    class CourseList

      include Yeeha::Query::Course
      include Yeeha::Parse::Course
      #include Yeeha::Middle::Course

      def initialize(client, year, sem)
        @client = client
        @year = year
        @sem = sem
        @course_list = []
      end
    end
  end
end
