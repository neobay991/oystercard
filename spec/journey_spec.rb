require 'journey'
require 'oystercard'
require 'station'

describe Journey do

  describe '#initialize' do

    it "should create an empty journey history array" do
      expect(subject.journey_history).to be_empty
    end

  end

  describe '#add_journey_history' do

    context 'when the user completes a journey' do

      let(:journey) {{ entry_s: "Aldgate", entry_s_zone: 1, exit_s: "Stratford" , exit_s_zone: 3 } }
      let(:entry_station) { double :station, name: "Aldgate", zone: 1 }
      let(:exit_station) { double :station, name: "Stratford", zone: 3 }

      it 'should store the journey history' do
        subject.start_journey(entry_station)
        subject.end_journey(exit_station)
        subject.add_journey_entry
        expect(subject.journey_history.size).to eq 1
      end

    end
  end

  describe '#start_journey ' do

    let(:station) { double :station, name: "Aldgate", zone: 1 }

    it "should record the entry_station" do
      card = OysterCard.new
      card.top_up(10)
      card.touch_in(station)
      subject.start_journey(station)
      expect(subject.entry_station).to eq station.name
    end

    it "should record the entry_station zone" do
      card = OysterCard.new
      card.top_up(10)
      card.touch_in(station)
      subject.start_journey(station)
      expect(subject.entry_station_zone).to eq station.zone
    end
  end

  describe '#end_journey ' do

    let(:station) { double :station, name: "Aldgate", zone: 1 }

    it "should record the entry_station" do
      card = OysterCard.new
      card.top_up(10)
      card.touch_in(station)
      subject.start_journey(station)
      subject.end_journey(station)
      expect(subject.exit_station).to eq station.name
    end

    it "should record the entry_station zone" do
      card = OysterCard.new
      card.top_up(10)
      card.touch_in(station)
      subject.start_journey(station)
      subject.end_journey(station)
      expect(subject.exit_station_zone).to eq station.zone
    end
  end
end
