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
        maximum_balance = OysterCard::MAX_BALANCE
        subject.top_up(maximum_balance)
        expect{subject.top_up(1)}.to raise_error "Maximum balance of #{maximum_balance} exceeded"
      end

      # it 'the balance should not change' do
      #   subject.top_up(100)
      #   expect(subject.balance).to eq 0
      # end

    end

  end

  describe '#deduct' do

    it 'should deduct the fare amount from balance' do
      subject.top_up(10)
      expect{subject.deduct 3}.to change{subject.balance}.by -3
    end

  end

  describe '#in_journey?' do

    it 'should return false when the card is created' do
      expect(subject).not_to be_in_journey
    end

  end

  describe '#touch_in' do

    it 'should set in_journey? to true' do
      subject.top_up(10)
      subject.touch_in("Aldgate")
      expect(subject).to be_in_journey
    end

     it "should record the entry_station" do
      subject.top_up(10)
      subject.touch_in("Aldgate")
      expect(subject.entry_station).to eq "Aldgate"
    end

    it 'should raise an error if balance is below minimum' do
      expect{subject.touch_in("Aldgate")}.to raise_error "cannot touch in, balance is below minimum amount"
    end

  end

  describe '#touch_out' do

    it 'should set in_journey? to false' do
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it "should forget the entry staton on touch_out" do
      subject.top_up(10)
      subject.touch_in("Aldgate")
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end

    it 'should reduce the balance by minimum fare' do
      subject.top_up(20)
      subject.touch_out
      expect{subject.deduct OysterCard::MIN_AMOUNT}.to change{subject.balance}.by -OysterCard::MIN_AMOUNT
    end

  end

end
