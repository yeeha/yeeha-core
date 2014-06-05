require 'yeeha/NTUT_client/query/request'

module Yeeha
  module Query
    module CourseSelection
      include Request
      def course_selection_list
        params = {'format'=>'-3','code'=> @client.student_id}
        uri = URI('http://aps.ntut.edu.tw/course/tw/Select.jsp')
        post_with_form(uri, params)
      end
    end

    module Course
      include Request
      def class_schedule
        params = {'format'=>'-2', 'code'=> @client.student_id}.merge!(to_hash)
        uri = URI('http://aps.ntut.edu.tw/course/tw/Select.jsp')
        uri.query = URI.encode_www_form(params)
        get(uri)
      end
    end
  end
end
