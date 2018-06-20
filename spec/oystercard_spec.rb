require 'oystercard'

describe OysterCard do

  describe '#initialize' do

    it 'should set balance with a default balance specified by a constant' do
      expect(subject.balance).to eq OysterCard::DEFAULT_BALANCE
    end

    it "should create an empty journey history array" do
      expect(subject.journey_history).to be_empty
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

    let(:entry_station) { double :station }
    let(:exit_station) { double :station }

    it 'should set in_journey? to true' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    let(:station) { double :station }

    it "should record the entry_station" do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

    it 'should raise an error if balance is below minimum' do
      expect{subject.touch_in(entry_station)}.to raise_error "cannot touch in, balance is below minimum amount"
    end

  end

  describe '#touch_out' do

    let(:entry_station) { double :station }
    let(:exit_station) { double :station }

    it 'should set in_journey? to false' do
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

    it "should forget the entry staton on touch_out" do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq nil
    end

    it 'should reduce the balance by minimum fare' do
      subject.top_up(20)
      subject.touch_out(exit_station)
      expect{subject.deduct OysterCard::MIN_AMOUNT}.to change{subject.balance}.by -OysterCard::MIN_AMOUNT
    end

    it "should record the exit_station" do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
   end

  end

  describe '#add_journey_history' do

    let(:entry_station) { double :station }
    let(:exit_station) { double :station }

    it "should store the journey history" do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey_history.size).to eq 1
    end

    # let(:zone) { double :station }
    # let(:zone) { double :station }
    #
    # it "should now stoe information about zones" do
    #   subject.top_up(10)
    #   subject.touch_in(zone)
    #   subject.touch_out(zone)
    #   expect(subject.journey_history[0][zone]).to eq zone
    # end
  end

end
