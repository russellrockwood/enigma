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
    reduced_shifts = shifts.map { |num| num % 27  }

    # shifts_labeled = {
    #   '0': reduced_shifts[0],
    #   '1': reduced_shifts[1],
    #   '2': reduced_shifts[2],
    #   '3': reduced_shifts[3],
    # }
  end


  # def shift_section(letters, shifts)
  #   shifted_section = ''
  #
  #   index = 0
  #   letters.each_char do |char|
  #     if !@alphabet.include?(char)
  #       shifted_section.concat(char)
  #     else
  #       shifted_section.concat(shift_letter(char, shifts[index]))
  #       index += 1
  #     end
  #   end
  #
  #   shifted_section
  # end

  def shift_letter(letter, number)
    rotate_alphabet = @alphabet.rotate(@alphabet.index(letter))
    shifted_letter = rotate_alphabet.rotate(number)[0]
  end

  def encrypt(message, key, date)
    # random_key = '%05d' % rand(5 ** 5)
    # sections = message.chars.each_slice(4).map(&:join)
    shifts = get_shifts(key, date)

    encrypted_message = ''
    index = 0
    message.each_char do |char|
      if index > 3
        index = 0
      end

      if !@alphabet.include?(char)
        puts 'special'
        encrypted_message.concat(char)
      else
        encrypted_message.concat(shift_letter(char, shifts[index]))
        index += 1
      end
    end

    encrypted_message
    # shifted_message = sections.map do |section|
    #   shift_section(section, shifts)
    # end.join('')

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
