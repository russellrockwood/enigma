module EncryptionFiles
  def encrypt_txt
    txt_file_to_encrypt = ARGV[0]
    new_encrypted_file_name = ARGV[1]

    file = File.open(txt_file_to_encrypt, "r")
    message = file.read.chomp

    encrypted_message = encrypt(message)

    new_file = File.open(new_encrypted_file_name, "w")
    new_file.write(encrypted_message[:encryption])
    new_file.close

    puts "Created \'#{new_encrypted_file_name}\' with the key #{encrypted_message[:key]} and date #{encrypted_message[:date]}"
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
