module Yeeha
  module Model
    class Course
      attr_accessor :number, :name, :stage, :credits, :hours, :must, :instructor, :class_belong, :class_room, :time

      def initialize
        @number = 0
        @name = ''
        @stage = 0
        @credits = 0
        @hours = 0
        @must = nil
        @instructor = []
        @class_belong = []
        @class_room = []
        @time = { :mon => [], :tue => [], :wed => [],
                  :thr => [], :fri => [], :sat => [], :sun => [] }
      end
    end
  end
end
