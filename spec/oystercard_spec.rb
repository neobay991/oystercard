require 'oystercard'

describe OysterCard do

  describe '#initialize' do

    it 'sets balance with a default balance specified by a constant' do
      expect(subject.balance).to eq OysterCard::DEFAULT_BALANCE
    end

  end

end
