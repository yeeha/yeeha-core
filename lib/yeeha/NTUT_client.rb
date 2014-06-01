require 'yeeha/NTUT_client/logging'
require 'yeeha/NTUT_client/query'

module Yeeha
  module NTUTClient
    include Logging
    extend Logging

    include Query
    extend Query
  end
end

puts Yeeha::NTUTClient.login_course_system
puts Yeeha::NTUTClient.login_course_system
puts Yeeha::NTUTClient.login_course_system
puts Yeeha::NTUTClient.login_course_system
