require './lib/encryption'
require 'date'
require 'pry'
# see 'working with files' lesson plan
class Enigma
  include Encryption
  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

  def get_date
    date = Time.now.strftime("%d/%m/%y").delete('/')
  end

  def random_key
    key = '%05d' % rand(5 ** 5)
  end

  def process_message(message, shifts)
    message = message.downcase

    processed_message = ''
    index = 0
    message.each_char do |char|
      if index > 3
        index = 0
      end
      if !@alphabet.include?(char)
        processed_message.concat(char)
      else
        processed_message.concat(shift_letter(char, shifts[index]))
        index += 1
      end
    end
    processed_message
  end

  def encrypt(message, key=nil, date=nil)
    if key == nil then key = random_key end
    if date == nil then date = get_date end
    shifts = get_shifts(key, date)
    encrypted_message = process_message(message, shifts)

    ecryption_info = {
      encryption: encrypted_message,
      key: key,
      date: date
    }
  end

  def decrypt(message, key, date=nil)
    if date == nil then date = get_date end
    shifts = get_shifts(key, date).map { |num| num * -1  }
    encrypted_message = process_message(message, shifts)

    decryption_info = {
      encryption: encrypted_message,
      key: key,
      date: date
    }
  end
end
