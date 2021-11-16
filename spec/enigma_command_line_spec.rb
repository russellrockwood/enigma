require './lib/enigma_command_line'

describe EnigmaCommandLine do
  before(:each) do
    @enigma_cl = EnigmaCommandLine.new
  end

  it 'exists' do
    expect(@enigma_cl).to be_a(EnigmaCommandLine)
  end

  it 'returns text from input files' do
    expected = 'hello world!'

    expect(@enigma_cl.get_message_from_txt('message.txt')).to eq(expected)
  end

  it 'it returns correct message if no file exists with input name' do
    file_name = 'no_file.txt'
    expected = "Cannot locate file 'no_file.txt'"

    expect(@enigma_cl.get_message_from_txt(file_name)).to eq(expected)
  end

  it 'creates confirmation message' do
    decryption_info =  {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }
    file_name = 'decrypted.txt'
    expected = "Created 'decrypted.txt' with the key 02715 and date 040895"

    expect(@enigma_cl.confirmation_message(file_name, decryption_info)).to eq(expected)
  end

  xit 'can write new text files' do
    @enigma_cl.write_file('test.txt', 'test text')

    expect(File.file?('test.txt')).to eq(true)
  end
end
