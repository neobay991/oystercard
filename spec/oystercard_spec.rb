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
    end
  end

  describe '#in_journey?' do
    let(:journey) { double :journey }

    it 'should return false when the card is created' do
      expect(subject.journey).not_to be_in_journey
    end

  end

  describe '#touch_in' do
    let(:entry_station) { double :station, name: 'Aldgate', zone: 1 }
    let(:exit_station) { double :station, name: 'Stratford', zone: 3 }
    let(:journey) { double :journey }

    it 'should set in_journey? to true' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect(subject.journey).to be_in_journey
    end

  end

  describe '#touch_out' do

    let(:entry_station) { double :station, name: 'Aldgate', zone: 1 }
    let(:exit_station) { double :station, name: 'Stratford', zone: 3 }
    let(:journey) { double :journey }

    it 'should set in_journey? to false' do
      subject.touch_out(exit_station)
      expect(subject.journey).not_to be_in_journey
    end

    it 'should forget the entry station on touch_out' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq nil
    end

  end

  describe '#fare' do

    let(:entry_station_z1) { double :station, name: 'Stratford', zone: 1 }
    let(:exit_station_z1) { double :station, name: "Oxford Street", zone: 1 }

    it 'should charge a minimum charge' do
      subject.top_up(10)
      subject.touch_in(entry_station_z1)
      subject.touch_out(exit_station_z1)
      expect(subject.balance).to eq 9
    end

    it 'should charge a penalty charge if fail to touch in' do
      subject.top_up(10)
      subject.touch_out(exit_station_z1)
      expect(subject.balance).to eq 4
    end

    it 'should charge a penalty charge if fail to touch out' do
      subject.top_up(10)
      subject.touch_in(entry_station_z1)
      subject.fare
      expect(subject.balance).to eq 4
    end

    context 'calculating the fare' do
      let(:entry_station_z1) { double :station, name: "Stratford", zone: 1 }
      let(:entry_station_z2) { double :station, name: "Canary Wharf", zone: 2 }
      let(:entry_station_z3) { double :station, name: "Stratford", zone: 3 }
      let(:entry_station_z4) { double :station, name: "Richmond", zone: 4 }
      let(:exit_station_z1) { double :station, name: "Oxford Street", zone: 1 }
      let(:exit_station_z2) { double :station, name: "Canada Water", zone: 2 }
      let(:exit_station_z3) { double :station, name: "Canning Town", zone: 3 }
      let(:exit_station_z4) { double :station, name: "Barking", zone: 4 }

      it 'should charge £1 for not crossing any zones' do
        subject.top_up(10)
        subject.touch_in(entry_station_z1)
        subject.touch_out(exit_station_z1)
        expect(subject.fare_amount).to eq 1
      end

      it 'should charge £2 for crossing 1 zone' do
        subject.top_up(10)
        subject.touch_in(entry_station_z1)
        subject.touch_out(entry_station_z2)
        expect(subject.fare_amount).to eq 2
      end

      it 'should charge £3 for crossing 2 zones' do
        subject.top_up(10)
        subject.touch_in(entry_station_z1)
        subject.touch_out(entry_station_z3)
        expect(subject.fare_amount).to eq 3
      end

      it 'should charge £4 for crossing 3 zones' do
        subject.top_up(10)
        subject.touch_in(entry_station_z1)
        subject.touch_out(entry_station_z4)
        expect(subject.fare_amount).to eq 4
      end
    end

    context 'calculating the fare even if the exit zone is higher than the entry zone' do

      let(:entry_station_z4) { double :station, name: 'Richmond', zone: 4 }
      let(:exit_station_z1) { double :station, name: 'Oxford Street', zone: 1 }

      it 'should charge £4 for crossing 3 zones' do
        subject.top_up(10)
        subject.touch_in(entry_station_z4)
        subject.touch_out(exit_station_z1)
        expect(subject.fare_amount).to eq 4
      end
    end

    context 'should reduce the balance based on fare charged' do

      let(:entry_station_z1) { double :station, name: 'Stratford', zone: 1 }
      let(:entry_station_z2) { double :station, name: 'Canary Wharf', zone: 2 }
      let(:entry_station_z3) { double :station, name: 'Stratford', zone: 3 }
      let(:entry_station_z4) { double :station, name: 'Richmond', zone: 4 }

      let(:exit_station_z1) { double :station, name: 'Oxford Street', zone: 1 }
      let(:exit_station_z2) { double :station, name: 'Canada Water', zone: 2 }
      let(:exit_station_z3) { double :station, name: 'Canning Town', zone: 3 }
      let(:exit_station_z4) { double :station, name: 'Barking', zone: 4 }

      it 'should reduce balance by £1 for crossing 0 zones' do
        subject.top_up(10)
        subject.touch_in(entry_station_z1)
        subject.touch_out(exit_station_z1)
        expect(subject.balance).to eq 9
      end

      it 'should reduce balance by £2 for crossing 1 zone' do
        subject.top_up(10)
        subject.touch_in(entry_station_z1)
        subject.touch_out(exit_station_z2)
        expect(subject.balance).to eq 8
      end

      it 'should reduce balance by £3 for crossing 2 zones' do
        subject.top_up(10)
        subject.touch_in(entry_station_z1)
        subject.touch_out(exit_station_z3)
        expect(subject.balance).to eq 7
      end

      it 'should reduce balance by £4 for crossing 3 zones' do
        subject.top_up(10)
        subject.touch_in(entry_station_z1)
        subject.touch_out(exit_station_z4)
        expect(subject.balance).to eq 6
      end
    end

  end

end
