require 'oystercard'

describe OysterCard do

  describe '#initialize' do

    it 'should set balance with a default balance specified by a constant' do
      expect(subject.balance).to eq OysterCard::DEFAULT_BALANCE
    end

  end

  describe '#top_up' do

    it 'should add top-up amount to balance' do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    context 'when user tries to top up more than the max' do

      it 'should raise an error' do
        expect{subject.top_up(100)}.to raise_error 'Max amount exceeded'
      end

      # it 'the balance should not change' do
      #   subject.top_up(100)
      #   expect(subject.balance).to eq 0
      # end

    end

  end

end
