require 'yeeha/NTUT_client/query/course'
require 'yeeha/NTUT_client/parse/course'

module Yeeha
  module Middle
    module Course
      def course_selection_list(query)
        Yeeha::Parse::Course.course_selection_list(
        Yeeha::Query::Course.course_selection_list(query))
      end

      def class_schedule(query)
        Yeeha::Parse::Course.class_schedule(
        Yeeha::Query::Course.class_schedule(query))
      end
    end
  end
end
