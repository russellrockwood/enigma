require './lib/enigma'

describe Enigma do
  before(:each) do
    @enigma = Enigma.new
    @test_key = 02715
    @test_date = 040895
  end

  it 'exists' do
    expect(@enigma).to be_a(Enigma)
  end

  it 'creates key hash' do
    expected = {
      :a => 02,
      :b => 27,
      :c => 71,
      :d => 15
     }

     expect(@enigma.get_keys(@test_key)).to eq(expected)
  end

end
