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
    # expected = {
    #   a: 3,
    #   b: 0,
    #   c: 19,
    #   d: 20,
    # }
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
    expect(@enigma.get_date.length).to eq(6)
  end

  it 'generates random key' do
    expect(@enigma.random_key.length).to eq(5)
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
      encryption: "hello world",
      key: "02715",
      date: "040895"
    }

      expect(@enigma.decrypt(message, @test_key, @test_date)).to eq(expected)
    end

end
