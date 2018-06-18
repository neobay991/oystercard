require 'oystercard'

describe OysterCard do

  describe '#initialize' do

    it 'sets balance with a default balance specified by a constant' do
      expect(subject.balance).to eq OysterCard::DEFAULT_BALANCE
    end

  end

  describe '#top_up' do
    it 'add top-up amount to balance ' do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

  end

end
