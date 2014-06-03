require 'yeeha/NTUT_client/middle'

module Yeeha
  class Course

    include CourseMiddle

    def initialize(client, year, sem)
      @client = client
      @year = year
      @sem = sem
    end

    def class_schedule
      res = super
      doc = Nokogiri::HTML(res.body)
      doc.xpath('/html/body/table/tr[*]/td/a').each do |klass|
        puts klass
      end
    end

    def to_hash
      {:year => @year, :sem => @sem}
    end
  end
end
