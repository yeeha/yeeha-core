class Course
  def initialize(client, year, sem)
    @client = client
    @year = year
    @sem = sem
  end

  def class_schedule
    params = {'format'=>'-2', 'code'=> @client.student_id}.merge!(to_hash)
    uri = URI('http://aps.ntut.edu.tw/course/tw/Select.jsp')
    uri.query = URI.encode_www_form(params)

    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri, @client.get_course_system_cookie)
    res = http.request(req)
    puts res.body

    doc = Nokogiri::HTML(res.body)
    doc.xpath('/html/body/table/tr[*]/td/a').each do |klass|
      puts klass
    end
  end

  def to_hash
    {:year => @year, :sem => @sem}
  end
end
