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

  it 'creates hash with proper shifts' do
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

  it 'correctly shifts string section' do
    string = 'hell'
    string_2 = 'rld'
    shifts = @enigma.get_shifts(@test_key, @test_date)

    expect(@enigma.shift_section(string, shifts)).to eq('kede')
    expect(@enigma.shift_section(string_2, shifts)).to eq('ulw')
  end

  xit 'encrypts messages' do
    message = 'hello world'

    expect(@enigma.encrypt(message, @test_key, @test_date)).to eq('keder ohulw')
  end

end
