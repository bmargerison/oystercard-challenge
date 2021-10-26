require 'oystercard'

describe Oystercard do
    it 'checks balance is 0 by default' do
        newcard = Oystercard.new
        expect(newcard.balance).to eq 0
    end

    it 'adds top-up amount to balance' do
        newcard = Oystercard.new
        newcard.top_up(50.00)
        expect(newcard.balance).to eq 50.00
    end

    it 'throws error if card limit exceeded' do
        maximum_balance = Oystercard::ACCOUNT_LIMIT
        subject.top_up(maximum_balance)
        expect{subject.top_up 1 }.to raise_error(RuntimeError)
    end
    
    it 'deducts money when spent' do
        subject.top_up(60)
        subject.spend(50)
        expect(subject.balance).to eq 10
    end

    it 'is initially not in a journey' do
        expect(subject).not_to be_in_journey
    end

    it 'touches in' do
        newcard = Oystercard.new
        newcard.top_up(2)
        newcard.touch_in
        expect(newcard).to be_in_journey
    end

    it 'touches out' do
        newcard = Oystercard.new
        newcard.top_up(2)
        newcard.touch_in
        newcard.touch_out
        expect(newcard).not_to be_in_journey
    end

    it "raise error if touched_in with not enough funds" do 
        newcard = Oystercard.new
        expect{ newcard.touch_in }.to raise_error "insufficient funds"
    end 

end