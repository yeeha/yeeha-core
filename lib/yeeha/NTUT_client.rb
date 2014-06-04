require 'nokogiri'
require 'yeeha/NTUT_client/logging'
require 'yeeha/NTUT_client/course_list'
require 'yeeha/NTUT_client/middle'

module Yeeha
  class NTUTClient
    include Logging
    include NTUTClientMiddle

    attr_reader :student_id

    def initialize(student_id)
      @client = self
      @student_id = student_id
    end

    def course_selection_list
      body = super
      @course_list = []
      doc = Nokogiri::HTML(body)
      doc.xpath('/html/body/table/tr/td/a/@href').each do |course_link|
        course_link_hash = params_to_hash(course_link.content)
        @course_list << CourseList.new(self, course_link_hash['year'], course_link_hash['sem'])
      end
      @course_list
    end

    private

    def params_to_hash(params)
      Hash[params.split('&').map{|d| d=d.split('='); [d[0], d[1]]}]
    end
  end
end
