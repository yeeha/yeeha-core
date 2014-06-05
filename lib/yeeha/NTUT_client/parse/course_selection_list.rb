require 'yeeha/NTUT_client/model/course_list'
require 'pry'
module Yeeha
  module Parse
    module CourseSelection

      def course_selection_list
        body = super
        @course_list = []
        doc = Nokogiri::HTML(body)
        doc.xpath('/html/body/table/tr/td/a/@href').each do |course_link|
          course_link_hash = params_to_hash(course_link.content)
          @course_list << Yeeha::Model::CourseList.new(self, course_link_hash['year'], course_link_hash['sem'])
        end
        @course_list
      end

      private

      def params_to_hash(params)
        Hash[params.split('&').map{|d| d=d.split('='); [d[0], d[1]]}]
      end
    end
  end
end
