require 'spec_helper'

describe 'Captcha' do

  let(:captcha_class) {Class.new {extend Yeeha::NTUTClient::Logging::Captcha}}

  it 'should OCR captcha image' do
    captcha_path = File.dirname(__FILE__) + '/authImage.png'
    captcha_text = captcha_class.send(:OCR_captcha, captcha_path)
    captcha_text.should == 'wcgq'
  end
end
