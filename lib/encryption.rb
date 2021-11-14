require 'date'

module Encryption
  def get_shifts(key,date)
    date_squared = (date.to_i ** 2).to_s
    date_squared_last_four = date_squared[date_squared.length - 4, 4]

    offsets = date_squared_last_four.split('').map {|s|s.to_i}
    keys = key.each_char.each_cons(2).map{|s| s.join.to_i}

    keys_offsets = [keys,offsets].transpose

    shifts = keys_offsets.map { |e| e.sum }
    reduced_shifts = shifts.map { |num| num % 27  }
  end

  def shift_letter(letter, number)
    rotate_alphabet = @alphabet.rotate(@alphabet.index(letter))
    shifted_letter = rotate_alphabet.rotate(number)[0]
  end
end
