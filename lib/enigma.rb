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
    txt_file_to_encrypt = ARGV[0]
    encrypted_new_file_name = ARGV[1]


    file = File.open(txt_file_to_encrypt, "r")
    message = file.read.chomp
    encrypted_message = encrypt(message)

    new_file = File.open(encrypted_new_file_name, "w")
    new_file.write(encrypted_message[:encryption])
    new_file.close

    puts "Created \'#{encrypted_new_file_name}\' with the key #{encrypted_message[:key]} and date #{encrypted_message[:date]}"
  end

  def decrypt_txt
    txt_file_to_decrypt = ARGV[0]
    new_decrypted_file_name = ARGV[1]
    input_key = ARGV[2]
    input_date = ARGV[3]

    file = File.open(txt_file_to_decrypt, "r")
    message = file.read.chomp
    decrypted_message = decrypt(message, input_key, input_date)

    new_file = File.open(new_decrypted_file_name, "w")
    new_file.write(decrypted_message[:decryption])
    new_file.close

    puts "Created \'#{new_decrypted_file_name}\' with the key #{decrypted_message[:key]} and date #{decrypted_message[:date]}"
  end
end
