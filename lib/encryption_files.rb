module EncryptionFiles
  def encrypt_txt
    message = get_message_from_txt(ARGV[0])
    message_info = encrypt(message)
    write_file(ARGV[1], message_info[:encryption])
    confirmation_message(ARGV[1], message_info)
  end

  def decrypt_txt
    message = get_message_from_txt(ARGV[0])
    message_info = decrypt(message, ARGV[2], ARGV[3])
    write_file(ARGV[1], message_info[:decryption])
    confirmation_message(ARGV[1], message_info)
  end

  def get_message_from_txt(file_name)
    file = File.open(file_name, "r")
    file.read.chomp
  end

  def write_file(file_name, text)
    new_file = File.open(file_name, "w")
    new_file.write(text)
    new_file.close
  end

  def confirmation_message(new_file_name, message_info)
    puts "Created \'#{new_file_name}\' with the key #{message_info[:key]} and date #{message_info[:date]}"
  end

end
