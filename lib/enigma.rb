require './lib/encryptor'

class Enigma
  include Encryptor
  # def initialize
  #
  # end

  def encrypt(message, key, date)
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
