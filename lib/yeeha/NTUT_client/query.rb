require 'nokogiri'
require 'net/https'

module Yeeha
  module NTUTClient
    module Query
      def query_course(params)
        uri = URI.parse('http://aps.ntut.edu.tw/course/tw/Select.jsp')
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Post.new(uri.path, header)
        req['code'] = '100360318'
        req['format'] = '-3'
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
