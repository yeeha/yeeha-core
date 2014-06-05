require 'tmpdir'
require 'open-uri'
require 'chunky_png'
require 'zlib'

module Yeeha
  module Logging
    module Captcha

      # Constant
      CAPTCHA_COLOR = ChunkyPNG::Color::WHITE
      CAPTCHA_LENGTH = 4
      CAPTCHA_TEMPDIR_PREFIX = 'yeeha_ntut_client_captcha'
      CAPTCHA_TEMPFILE_NAME = 'capcha.png'
      CAPTCHA_URL = "https://nportal.ntut.edu.tw/authImage.do"
      CAPTCHA_TABLE = {
        "93089573"   => "a",
        "3600920218" => "b",
        "1822249504" => "c",
        "385668458"  => "d",
        "3924481127" => "e",
        "3021080999" => "f",
        "4064154253" => "g",
        "3059517062" => "h",
        "502913828"  => "i",
        "3218539739" => "j",
        "3803476923" => "k",
        "151412862"  => "l",
        "1406234036" => "m",
        "3229056929" => "n",
        "3875636813" => "o",
        "1022056829" => "p",
        "323143079"  => "q",
        "3700579710" => "r",
        "3656043636" => "s",
        "1648619929" => "t",
        "2226595823" => "u",
        "3819637781" => "v",
        "4254263836" => "w",
        "3423968056" => "x",
        "2172007339" => "y",
        "58008777"   => "z"
      }

      def get_captcha_text(cookie = '')
        get_captcha(cookie) do |captcha_path|
          OCR_captcha(captcha_path)
        end
      end

      private

      def OCR_captcha(captcha_path)
        # Mask
        capchaImage = ChunkyPNG::Image.from_file(captcha_path)
        capchaTextImage = capchaImage.extract_mask(CAPTCHA_COLOR, 0)[1]

        # Crop & OCR
        captchaText = ""
        cropWidth = ((capchaTextImage.dimension.width)/CAPTCHA_LENGTH).round
        CAPTCHA_LENGTH.times do |i|
          capchaTextImageExcerpt = capchaTextImage.crop(
            i*cropWidth, 0,
            cropWidth, capchaTextImage.dimension.height)
          key = Zlib.crc32(capchaTextImageExcerpt.to_s).to_s
          captchaText += CAPTCHA_TABLE[key]
        end
        captchaText
      end

      def get_captcha(cookie)
        Dir.mktmpdir(CAPTCHA_TEMPDIR_PREFIX) { |dir|
          captcha_path = dir + '/' + CAPTCHA_TEMPFILE_NAME
          open(captcha_path, 'wb') do |file|
            file << open(CAPTCHA_URL, cookie).read
          end
          yield captcha_path
        }
      end
    end
  end
end
