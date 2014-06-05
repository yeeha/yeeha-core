require 'net/https'
require 'nokogiri'
require 'yeeha/config/config'
require 'yeeha/NTUT_client/loggin/captcha'

module Yeeha
  module Logging

    include Captcha

    COOKIE_TIME_OUT = 30*60
    COURSE_SYSTEM_TIME_OUT = 30*60

    @@course_system_cookie = nil
    @@portal_cookie = nil
    @@portal_expire_time = nil
    @@course_system_expire_time = nil

    def get_course_system_cookie
      if course_system_time_out?
        @@course_system_cookie = login_course_system(get_portal_cookie)
      else
        @@course_system_cookie
      end
    end

    private

    def get_portal_cookie
      if portal_timeout?
        @@portal_cookie = login_portal(Yeeha::Config::USER[:username], Yeeha::Config::USER[:password])
      else
        @@portal_cookie
      end
    end

    def login_portal(username, password)
      uri = URI.parse('https://nportal.ntut.edu.tw/login.do')
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      # First call to get cookie
      req = Net::HTTP::Post.new(uri.path)
      res = https.request(req)
      cookie = get_cookie_from_response res

      # Second call to get captcha text using exist cookie
      captcha_text = get_captcha_text(cookie)

      # Third call to login portal using captcha and cookie
      req = Net::HTTP::Post.new(uri.path, cookie)
      req.set_form_data({
        'muid' => username,
        'mpassword' => password,
        'authcode' => captcha_text
      })
      res = https.request(req)

      if res.code == '200'
        set_portal_expire_stamp
        cookie
      else
        raise "Error login portal"
      end
    end

    def login_course_system(portal_cookie)
      # First call to get sessionId
      uri = URI('http://nportal.ntut.edu.tw/ssoIndex.do?apUrl=http://aps.ntut.edu.tw/course/tw/courseSID.jsp&apOu=aa_0010')
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Get.new(uri, portal_cookie)
      res = http.request(req)

      # Parse form data including sessionId
      form_data = {}
      Nokogiri::HTML(res.body).xpath('/html/body/form/input').each do |form|
        form_data[form['name']] = form['value']
      end

      # Second call to login course system
      uri = URI('http://aps.ntut.edu.tw/course/tw/courseSID.jsp')
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Post.new(uri, portal_cookie)
      req.set_form_data(form_data)
      res = http.request(req)

      if res.code == '200'
        set_course_system_time_expire_stamp
        portal_cookie
      else
        raise "Error login course system"
      end
    end

    def get_cookie_from_response(res)
      header = Hash[res.to_hash['set-cookie'][0].split(';').map{|d| d=d.split('='); [d[0], d[1]]}]
      {'Cookie' => 'JSESSIONID=' + header['JSESSIONID']}
    end

    def portal_timeout?
      @@portal_expire_time.nil? || @@portal_expire_time < Time.now
    end

    def set_portal_expire_stamp
      @@portal_expire_time = Time.now + COOKIE_TIME_OUT
    end

    def course_system_time_out?
      @@course_system_expire_time.nil? || @@course_system_expire_time < Time.now
    end

    def set_course_system_time_expire_stamp
      @@course_system_expire_time = Time.now + COURSE_SYSTEM_TIME_OUT
    end
  end
end
