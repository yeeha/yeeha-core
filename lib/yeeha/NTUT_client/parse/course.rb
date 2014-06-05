require 'yeeha/NTUT_client/model/course'
require 'yeeha/NTUT_client/query/course'

module Yeeha
  module Parse
    module Course
      def class_schedule
        body = super
        doc = Nokogiri::HTML(body)
        table = doc.xpath('//table').max_by {|t| t.xpath('.//tr').length}
        rows = table.search('tr')[3..-2]
        rows.each do |row|
          cells = row.search('td')
          course = Yeeha::Model::Course.new
          cells.each_with_index do |col, i|
            col.xpath('.//text()[normalize-space()]').each do |text|
              text = text.to_s.gsub("\u3000", '')
              case i
                when 0  then course.number = text
                when 1  then course.name = text
                when 2  then course.stage= text
                when 3  then course.credits = text
                when 4  then course.hours = text
                when 5  then course.must = text=='必'
                when 6  then course.instructor << text
                when 7  then course.class_belong << text
                when 8  then course.time[:sun] = text.split
                when 9  then course.time[:mon] = text.split
                when 10 then course.time[:tue] = text.split
                when 11 then course.time[:wed] = text.split
                when 12 then course.time[:thr] = text.split
                when 13 then course.time[:fri] = text.split
                when 14 then course.time[:sat] = text.split
                when 15 then course.class_room = text.split
              end
            end
          end
          @course_list << course
        end
        @course_list
      end

      def to_hash
        {:year => @year, :sem => @sem}
      end
    end
  end
end
