require './lib/encryptor'
require 'date'
require 'pry'
# see 'working with files' lesson plan
class Enigma
  include Encryptor
  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

  def get_shifts(key,date)
    date_squared = (date.to_i ** 2).to_s
    date_squared_last_four = date_squared[date_squared.length - 4, 4]

    offsets = date_squared_last_four.split('').map {|s|s.to_i}
    keys = key.each_char.each_cons(2).map{|s| s.join.to_i}

    keys_offsets = [keys,offsets].transpose

    shifts = keys_offsets.map { |e| e.sum }
  end

  def encrypt(message, key, date)
    # random_key = '%05d' % rand(5 ** 5)

     # If the key is not included, generate a random key.

     # If the date is not included, use today’s date.

     # The encrypt method returns a hash with three keys:

    # :encryption => the encrypted String
    # :key => the key used for encryption as a String
    # :date => the date used for encryption as a String in the form DDMMYY
  end

  def decrypt(ciphertext, key, date)
    # The decrypt method takes a ciphertext String and the Key used for encryption as arguments.

    # The decrypt method can optionally take a date as the third argument.

    # If no date is given, this method should use today’s date for decryption.

    # The decrypt method returns a hash with three keys:

    # :decryption => the decrypted String
    # :key => the key used for decryption as a String
    # :date => the date used for decryption as a String in the form DDMMYY
  end
end
