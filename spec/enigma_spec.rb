require './spec/spec_helper'
require './lib/enigma'

describe Enigma do
  before(:each) do
    @enigma = Enigma.new
    @test_key = '02715'
    @test_date = '040895'
  end

  it 'exists' do
    expect(@enigma).to be_a(Enigma)
  end

  it 'creates array with proper shifts' do
    expected = [3, 0, 19, 20]

     expect(@enigma.get_shifts(@test_key, @test_date)).to eq(expected)
  end

  it 'shifts single letters correctly' do
    letter = 'h'
    letter_2 = 'l'

    shift = 3
    shift_2 = 19

    expect(@enigma.shift_letter(letter, shift)).to eq('k')
    expect(@enigma.shift_letter(letter_2, shift_2)).to eq('d')
  end

  it 'returns date in correct format' do
    expected = Time.now.strftime("%d/%m/%y").delete('/')

    expect(@enigma.get_date.length).to eq(6)
    expect(@enigma.get_date).to eq(expected)
  end

  it 'checks for invalid keys' do
    key_1 = 12234
    key_2 = '8&k89'
    key_3 = '123456'

    expect(@enigma.valid_key?(key_1)).to eq(false)
    expect(@enigma.valid_key?(key_2)).to eq(false)
    expect(@enigma.valid_key?(key_3)).to eq(false)
    expect(@enigma.valid_key?(@test_key)).to eq(true)
  end

  it 'generates random key' do
    random_key = @enigma.random_key

    expect(random_key.length).to eq(5)
    expect(@enigma.valid_key?(random_key)).to eq(true)
  end

  it 'processes messages' do
    shifts = [3, 0, 19, 20]
    neg_shifts = [-3, 0, -19, -20]

    expect(@enigma.process_message('hello world', shifts)).to eq("keder ohulw")
    expect(@enigma.process_message("keder ohulw", neg_shifts)).to eq('hello world')
  end

  it 'encrypts messages' do
    message = 'hello world'
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    expect(@enigma.encrypt(message, @test_key, @test_date)).to eq(expected)
  end

  it 'decrypts messages' do
    message = 'keder ohulw'
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

      expect(@enigma.decrypt(message, @test_key, @test_date)).to eq(expected)
    end

    it 'returns text from input files' do
      expected = 'hello world!'

      expect(@enigma.get_message_from_txt('message.txt')).to eq(expected)
    end

    it 'it returns correct message if no file exists with input name' do
      file_name = 'no_file.txt'
      expected = "Cannot locate file 'no_file.txt'"

      expect(@enigma.get_message_from_txt(file_name)).to eq(expected)
    end

    it 'creates confirmation message' do
      decryption_info =  {
        decryption: "hello world",
        key: "02715",
        date: "040895"
      }
      file_name = 'decrypted.txt'
      expected = "Created 'decrypted.txt' with the key 02715 and date 040895"

      expect(@enigma.confirmation_message(file_name, decryption_info)).to eq(expected)
    end

    it 'can write new text files' do
      test_file = @enigma.write_file('test.txt', 'test text')

      expect(File.file?('test.txt')).to eq(true)
    end

end
