require 'yeeha/NTUT_client/middle/middle'

module Yeeha
  class NTUTClient

    include Yeeha::Middle::Course

    attr_reader :student_id

    def initialize(student_id)
      @student_id = student_id
    end

    def course_selection_list
      @course_selection_list ||= super({:code => @student_id})
    end

    def class_schedule(query)
      super(query.merge({:code => @student_id}))
    end
  end
end
