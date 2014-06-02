require 'nokogiri'
require 'net/https'
require 'yeeha/NTUT_client/logging'
require 'yeeha/NTUT_client/course'

module Yeeha
  class NTUTClient
    include Logging

    attr_reader :student_id

    def initialize(student_id)
      @student_id = student_id
    end

    def course_selection_list
      params = {'format'=>'-3','code'=> student_id}
      uri = URI('http://aps.ntut.edu.tw/course/tw/Select.jsp')

      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Post.new(uri, get_course_system_cookie)
      req.set_form_data(params)
      res = http.request(req)

      @course_list = []
      doc = Nokogiri::HTML(res.body)
      doc.xpath('/html/body/table/tr/td/a/@href').each do |course_link|
        course_link_hash = params_to_hash(course_link.content)
        @course_list << Course.new(self, course_link_hash['year'], course_link_hash['sem'])
      end
      @course_list
    end

    private

    def params_to_hash(params)
      Hash[params.split('&').map{|d| d=d.split('='); [d[0], d[1]]}]
    end
  end
end
