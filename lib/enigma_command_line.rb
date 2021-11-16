require './lib/enigma'

class EnigmaCommandLine < Enigma

  def process_txt_file
    message = get_message_from_txt(ARGV[0])
    if ARGV.length == 2
      message_info = encrypt(message)
      write_file(ARGV[1], message_info[:encryption])
    elsif ARGV.length == 4
      message_info = decrypt(message, ARGV[2], ARGV[3])
      write_file(ARGV[1], message_info[:decryption])
    else
      puts '* Error *'
      puts 'To Encrypt: <file_name.txt> <new_encrypted_file_name.txt>'
      puts 'To Decrypt: <encrypted_file_name.txt> <new_decrypted_file_name.txt> <key> <date>'
      exit
    end
    puts confirmation_message(ARGV[1], message_info)
  end

  def get_message_from_txt(file_name)
    if !File.file?(file_name)
      return "Cannot locate file \'#{file_name}\'"
    end
    file = File.open(file_name, "r")
    file.read.chomp
  end

  def write_file(file_name, text)
    new_file = File.open(file_name, "w")
    new_file.write(text)
    new_file.close
  end

  def confirmation_message(new_file_name, message_info)
    "Created \'#{new_file_name}\' with the key #{message_info[:key]} and date #{message_info[:date]}"
  end

end
