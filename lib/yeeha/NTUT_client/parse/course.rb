require 'yeeha/NTUT_client/model/course'
require 'yeeha/NTUT_client/model/course_selection_list'

module Yeeha
  module Parse
    module Course

      def self.course_selection_list(body)
        course_selection_list = []
        doc = Nokogiri::HTML(body)
        doc.xpath('/html/body/table/tr/td/a/@href').each do |course_selection_link|
          course_selection_link_hash = params_to_hash(course_selection_link.content)
          course_selection_list << Yeeha::Model::CourseSelectionList.new(
            course_selection_link_hash['year'], course_selection_link_hash['sem'])
        end
        course_selection_list
      end

      def self.class_schedule(body)
        doc = Nokogiri::HTML(body)
        course_list = []
        table = doc.xpath('//table').max_by {|t| t.xpath('.//tr').length}
        rows = table.search('tr')[3..-2]
        rows.each do |row|
          cells = row.search('td')
          course = Yeeha::Model::Course.new
          cells.each_with_index do |col, i|
            col.xpath('.//text()[normalize-space()]').each do |text|
              text = text.to_s.gsub("\u3000", '')
              case i
                when 0  then course.number = text.to_i
                when 1  then course.name = text
                when 2  then course.stage= text.to_i
                when 3  then course.credits = text.to_i
                when 4  then course.hours = text.to_i
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
          course_list << course
        end
        course_list
      end

      private

      def self.params_to_hash(params)
        Hash[params.split('&').map{|d| d=d.split('='); [d[0], d[1]]}]
      end
    end
  end
end
