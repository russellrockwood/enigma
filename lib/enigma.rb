require './lib/caesar_cipher'
require 'date'

class Enigma
  include CaesarCipher
  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

  def encrypt(message, key=nil, date=nil, dir=1)
    if key == nil then key = random_key end
    if date == nil then date = get_date end
    if !valid_key?(key) then return 'Invalid key' end

    shifts = get_shifts(key, date).map { |num| num * dir  }
    message = process_message(message, shifts)
    if dir == 1
      label = :encryption
    else
      label = :decryption
    end

    info = {
      key: key,
      date: date
    }
    info[label] = message
    info
  end

  def decrypt(message, key, date=nil, dir=-1)
    encrypt(message, key, date, dir)
  end
end
