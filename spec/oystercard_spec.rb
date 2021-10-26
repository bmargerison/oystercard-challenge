require 'oystercard'

describe Oystercard do
    let(:station){ double :station }
    let(:station_2){ double :station_2 }
    let(:newcard) { Oystercard.new }

    it 'checks balance is 0 by default' do
        expect(newcard.balance).to eq 0
    end

    it 'adds top-up amount to balance' do
        newcard.top_up(50.00)
        expect(newcard.balance).to eq 50.00
    end

    it 'throws error if card limit exceeded' do
        maximum_balance = Oystercard::ACCOUNT_LIMIT
        subject.top_up(maximum_balance)
        expect{subject.top_up Oystercard::MINIMUM_FARE }.to raise_error(RuntimeError)
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
        newcard.top_up(2)
        newcard.touch_in(station)
        expect(newcard).to be_in_journey
    end

    it 'touches out' do
        newcard.top_up(2)
        newcard.touch_in(station)
        newcard.touch_out(station)
        expect(newcard).not_to be_in_journey
    end

    it "raise error if touched_in with not enough funds" do 
        expect{ newcard.touch_in(station) }.to raise_error "insufficient funds"
    end 

    it "reduces balance by the journey cost amount" do
        newcard.top_up(50)
        expect{newcard.touch_out(station)}.to change{newcard.balance}.by(-Oystercard::MINIMUM_FARE)
    end

    it "records station customer has travelled from" do 
        newcard.top_up(3)
        newcard.touch_in(station)
        expect(newcard.entry_station).to eq(station)
    end

    it "sets entry_station to nil when card touched out" do 
        newcard.top_up(3)
        newcard.touch_in(station)
        newcard.touch_out(station)
        expect(newcard.entry_station).to eq nil
    end 

    it 'has no journeys by default' do
        expect(subject.journeys).to be_empty
    end

    it 'creates a journey after touching in' do
        newcard.top_up(3)
        newcard.touch_in('reading')
        newcard.touch_out('london')
        expect(newcard.journeys['reading']).to eq 'london'
    end

end 






