require 'oystercard'

describe OysterCard do

  describe '#initialize' do

    it 'sets balance to 0' do
      expect(subject.balance).to eq 0
    end

  end

end
