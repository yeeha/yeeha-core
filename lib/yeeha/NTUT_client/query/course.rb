require 'yeeha/NTUT_client/query/request'

module Yeeha
  module Query
    module Course
      extend Request

      def self.course_selection_list(query = {:code => nil})
        params = {:format=>'-3'}.merge!(query)
        uri = URI('http://aps.ntut.edu.tw/course/tw/Select.jsp')
        post_with_form(uri, params)
      end

      def self.class_schedule(query = {:code=> nil, :year => nil, :sem => nil})
        params = {:format=>'-2'}.merge!(query)
        uri = URI('http://aps.ntut.edu.tw/course/tw/Select.jsp')
        uri.query = URI.encode_www_form(params)
        get(uri)
      end
    end
  end
end
