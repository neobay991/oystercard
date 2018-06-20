require 'station'

describe Station do

  describe '#initialize' do
    # another way to write it
    # subject {described_class.new(name: "Old Street", zone: 1)}
    subject {described_class.new("Old Street", 1)}

    it 'knows its name' do
      expect(subject.name).to eq("Old Street")
    end

    it 'knows its zone' do
      expect(subject.zone).to eq(1)
    end
  end
end
