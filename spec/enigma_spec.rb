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
    expected = [3, 27, 73, 20]

     expect(@enigma.get_shifts(@test_key, @test_date)).to eq(expected)
  end

  it 'shifts letters correctly' do
    string_1 = 'hell'
    string_2 = 'o wo'
    shifts = @enigma.get_shifts(@test_key, @test_date)

    expect(@enigma.shift_four(string_1, shifts)).to eq('kede')
    expect(@enigma.shift_four(string_2, shifts)).to eq('r oh')
  end

end
