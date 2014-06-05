require 'net/https'

module Yeeha
  module Query
    module Request
      def get(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Get.new(uri, @client.get_course_system_cookie)
        res = http.request(req)
        cp950_to_utf8(res.body)
      end

      def post_with_form(uri, form_data)
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Post.new(uri, @client.get_course_system_cookie)
        req.set_form_data(form_data)
        res = http.request(req)
        cp950_to_utf8(res.body)
      end

      private

      def cp950_to_utf8(s)
        s.force_encoding('CP950').encode!('UTF-8')
      end
    end
  end
end
