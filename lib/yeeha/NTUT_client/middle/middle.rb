require 'yeeha/NTUT_client/query/course'
require 'yeeha/NTUT_client/parse/course'
require 'yeeha/NTUT_client/parse/course_selection_list'

module Yeeha
  module Middle
    module Course
      include Yeeha::Query::Course
      include Yeeha::Parse::Course
    end
    module CourseSelection
      include Yeeha::Query::CourseSelection
      include Yeeha::Parse::CourseSelection
    end
  end
end
