require './lib/encryption'
require 'date'
require 'pry'

class Enigma
  include Encryption
  def initialize
    @alphabet = ("a".."z").to_a << " "
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
    decrypted_message = process_message(message, shifts)

    decryption_info = {
      decryption: decrypted_message,
      key: key,
      date: date
    }
  end

  def encrypt_txt
    file = File.open('./message.txt', "r")
    message = file.read.chomp
    encrypted_message = encrypt(message)

    new_file = File.open(ARGV[1], "w")
    new_file.write(encrypted_message[:encryption])
    new_file.close

    puts "Created \'#{ARGV[1]}\' with the key #{encrypted_message[:key]} and date #{encrypted_message[:date]}"
  end
end
