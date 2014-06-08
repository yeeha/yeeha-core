module Yeeha
  module Model
    class CourseSelectionList

      attr_reader :year, :sem

      def initialize(year, sem)
        @year = year
        @sem = sem
      end

      def to_hash
        {:year => @year, :sem => @sem}
      end
    end
  end
end
