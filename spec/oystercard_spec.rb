require 'oystercard'

describe OysterCard do
  describe 'check balance is 0 at the start' do
    expect(subject.balance).to eq 0
  end

end
