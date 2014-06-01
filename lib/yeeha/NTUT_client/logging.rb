require 'yeeha/NTUT_client/captcha'
require 'yeeha/config/config'

module Yeeha
  module NTUTClient
    module Logging

      include Captcha
      extend Captcha

      COOKIE_TIME_OUT = 30*60
      COURSE_SYSTEM_TIME_OUT = 30*60

      def login_course_system
        if course_system_time_out?
          header = get_cookie
          uri = URI('http://nportal.ntut.edu.tw/ssoIndex.do?apOu=aa_0010')
          http = Net::HTTP.new(uri.host, uri.port)
          req = Net::HTTP::Get.new(uri, header)
          res = http.request(req)
          if res.code == '200'
            set_course_system_time_expire_stamp
            puts 'Login course system successful'
          else
            raise "Error login course system"
          end
        else
          puts 'Cached! Login course system successful'
        end
      end

      private

      def request_new_cookie(username, password)
        uri = URI.parse('https://nportal.ntut.edu.tw/login.do')
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        req = Net::HTTP::Post.new(uri.path)

        req['muid'] = username
        req['mpassword'] = password
        req['authcode'] = get_captcha_text

        res = https.request(req)
        if res.code == '200'
          set_cookie_time_expire_stamp
          header = Hash[res.to_hash['set-cookie'][0].split(';').map{|d| d=d.split('='); [d[0], d[1]]}]
          @cookie = {'Cookie' => 'JSESSIONID=' + header["JSESSIONID"]}
        else
          raise "Error get cookie"
        end
      end

      def get_cookie
        if cookie_timeout?
          puts "Get cookie"
          request_new_cookie(NTUTClient::Config::USER[:username], NTUTClient::Config::USER[:password])
        else
          puts "Cached! Get cookie"
          @cookie
        end
      end

      def cookie_timeout?
        @cookie_expire_time.nil? || @cookie_expire_time < Time.now
      end

      def set_cookie_time_expire_stamp
        @cookie_expire_time = Time.now + COOKIE_TIME_OUT
      end

      def course_system_time_out?
        @course_system_expire_time.nil? || @course_system_expire_time < Time.now
      end

      def set_course_system_time_expire_stamp
        @course_system_expire_time = Time.now + COURSE_SYSTEM_TIME_OUT
      end
    end
  end
end
