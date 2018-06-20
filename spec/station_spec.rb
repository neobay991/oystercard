require 'station'

describe Station do

  describe '#initialize' do
    # the subject line is taken from the ex. 13 walkthrough
    subject {described_class.new(name: "Old Street", zone: 1)}

    it 'knows its name' do
      expect(subject.name).to eq("Old Street")
    end

    it 'knows its zone' do
      expect(subject.zone).to eq(1)
    end
  end
end
