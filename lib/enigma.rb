require './lib/encryption'
require './lib/encryption_files'
require 'date'
require 'pry'

class Enigma
  include EncryptionFiles
  include Encryption
  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

  def encrypt(message, key=nil, date=nil)
    if key == nil then key = random_key end
    if date == nil then date = get_date end
    if !valid_key?(key) then return 'Invalid key'end



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
    if !valid_key?(key) then return 'Invalid key'end

    shifts = get_shifts(key, date).map { |num| num * -1  }
    decrypted_message = process_message(message, shifts)

    decryption_info = {
      decryption: decrypted_message,
      key: key,
      date: date
    }
  end

end
