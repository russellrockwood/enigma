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
    puts ARGV[0], ARGV[1]

    # $ ruby ./lib/encrypt.rb message.txt encrypted.txt
    # Created 'encrypted.txt' with the key 82648 and date 240818

    file = File.open('./message.txt', "r")
    message = file.read.chomp
    encrypted_message = encrypt(message)
    puts "Created \'#{ARGV[1]}\' with the key #{encrypted_message[:key]} and date #{encrypted_message[:date]}"
    # message.write("hello world!")
    # message.close
  end
end
