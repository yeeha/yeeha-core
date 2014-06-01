require 'nokogiri'
require 'net/https'
require 'yeeha/NTUT_client/logging'

module Yeeha
  module NTUTClient
    module Query

      include Logging
      extend Logging

      def query_course(params)
        params = {'format'=>'-2','year'=>'102', 'sem'=>'2','code'=>'100360318'}
        header = get_course_system_cookie
        uri = URI('http://aps.ntut.edu.tw/course/tw/Select.jsp')
        uri.query = URI.encode_www_form(params)

        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Get.new(uri, header)

        res = http.request(req)
        puts res.body.to_s

        # doc = Nokogiri::HTML(res)
        # puts doc.to_s
        # doc.xpath('/html/body/table/tbody/tr[*]/td/a').each do |link|
        #   puts link.content
        # end
      end
    end
  end
end
