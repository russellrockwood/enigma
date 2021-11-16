module CaesarCipher
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

  def get_date
    Time.now.strftime("%d/%m/%y").delete('/')
  end

  def random_key
    '%05d'% rand(6**6)
  end

  def valid_key?(key)
    if key.class != String
      return false
    end

    if key.length != 5
      return false
    end

    key.each_char do |num|
      if !('0'..'9').include?(num)
        return false
      end
    end

    true
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
end
